module PlansHelper

  def project_list_head(column)
    klass = case column
      when :name  then :dmp_th_big
      when :owner then :dmp_th_medium
      else :dmp_th_small
    end

    content_tag(:th, t("helpers.project.columns.#{column}"), class: klass)
  end

  def project_list_body(column, project)
    klass, content = case column
      when :name
        [ 'dmp_td_big', link_to(project.title, project_path(project), class: 'dmp_table_link') ]
      when :owner
        user = project.owner
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
