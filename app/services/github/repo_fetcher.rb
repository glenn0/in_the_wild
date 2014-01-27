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
      response = Net::HTTP.get_response(URI.parse("https://status.github.com/api/status.json"))
      json = ActiveSupport::JSON.decode(response.body)
      json["status"] == "good"
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
      response = Net::HTTP.get_response(URI.parse("https://api.github.com/repos/#{@project.repo_owner}/#{@project.repo_name}"))
      json = ActiveSupport::JSON.decode(response.body)
      @project.repo_owner_avatar = json["owner"]["gravatar_id"]
      @project.repo_description = json["description"]
    end

    def generate_rspec_tags
      response = Net::HTTP.get_response(URI.parse("https://api.github.com/repos/#{@project.repo_owner}/#{@project.repo_name}/contents/spec"))
      json = ActiveSupport::JSON.decode(response.body)
      json.each do |item|
        if item["type"] == "dir"
          dir_name = item["name"]
          @project.tags << Tag.where(name: dir_name).first_or_create
        end
      end
    end

  end
end