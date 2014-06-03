module PlansHelper

  def project_list_head(column)
    klass, content = case column
      when :name        then %w( dmp_th_big    helpers.name )
      when :owner       then %w( dmp_th_medium helpers.owner )
      when :shared      then %w( dmp_th_small  helpers.project.share.shared_label )
      when :last_edited then %w( dmp_th_small  helpers.last_edit )
      else # Attempt a sensible default
        [ 'dmp_th_small', column ]
    end

    content_tag(:th, t(content), class: klass)
  end

  def project_list_body(column, project)
    klass, content = case column
      when :name
        [ 'dmp_td_big', link_to(project.title, project_path(project), class: 'dmp_table_link') ]
      when :owner
        user = project.project_groups.find_by_project_creator(true).try(:user)
        text = if user.nil?
          'Unknown'
        elsif user == current_user
          t('helpers.me')
        else
          user.name
        end

        [ 'tmp_td_medium', text ]
      when :shared
        shared_num = project.project_groups.count - 1
        text = shared_num > 0 ? (t('helpers.yes') + " (with #{shared_num} people) ") : t('helpers.no')
        [ 'dmp_td_small', text ]
      when :last_edited
        [ 'dmp_td_small', l(project.latest_update.to_date, formats: :short) ]
      else
        [ 'dmp_td_small', (project.try(column) || 'Unknown') ]
    end

    content_tag(:td, content, class: klass)
  end

end
