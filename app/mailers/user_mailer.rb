class UserMailer < ActionMailer::Base

        def sharing_notification(project_group)
                @project_group = project_group
                mail(to: @project_group.user.email, subject: t('helpers.mailer.sharing_notification'))
        end

        def permissions_change_notification(project_group)
                @project_group = project_group
                mail(to: @project_group.user.email, subject: t('helpers.mailer.permissions_change'))
        end

        def project_access_removed_notification(user, project)
                @user = user
                @project = project
                mail(to: @user.email, subject: t('helpers.mailer.access_removed'))
        end
end
