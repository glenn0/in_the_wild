module Github
  class RepoFetcher

    def initialize(project, submitter)
      @project = project
      @submitter = submitter
    end

    def retrieve
      if github_up?
        fetch_repo_owner_and_name
        if valid_repo? 
          get_additional_repo_attributes
          generate_rspec_tags
          if @project.save
            Submission.create(user_id: @submitter.id, project_id: @project.id)
            ServiceResponse.success
          else
            ServiceResponse.error_with_message("Hmmm... that's not a URL I can understand at the moment.")
          end
        else
          ServiceResponse.error_with_message("Hmmm... that's not a URL I can understand at the moment.")
        end
      else
        ServiceResponse.error_with_message("Bother, looks like <a href='https://status.github.com/'> GitHub is down</a> at the moment")
      end
    end

    def github_up?
      Octokit.github_status.status == "good"
    end

    def fetch_repo_owner_and_name
      repo_from_url = Octokit::Repository.from_url(@project.url)
      @project.repo_owner = repo_from_url.owner
      @project.repo_name = repo_from_url.name
      @project.repo_owner_url = "https://github.com/#{repo_from_url.owner}"
      @project.repo_url = "https://github.com/#{repo_from_url.owner}/#{repo_from_url.name}" 
    end

    def valid_repo?
      Octokit.repository?("#{@project.repo_owner}/#{@project.repo_name}")
    end

    def get_additional_repo_attributes
      repo = Octokit.repository("#{@project.repo_owner}/#{@project.repo_name}")
      @project.repo_owner_avatar = repo.owner.gravatar_id
      @project.repo_description = repo.description
    end

    def generate_rspec_tags
      spec_contents = Octokit.contents("#{@project.repo_owner}/#{@project.repo_name}", path: 'spec')
      spec_contents.each do |i|
        if i.type == "dir"
          dir_name = i.name
          @project.tags << Tag.where(name: dir_name).first_or_create
        end
      end
    end
  end
end