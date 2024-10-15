
# AWS Terraform GitHub Actions Setup

## Steps to Configure and Run GitHub Actions

1. **Authenticate with GitHub Using CLI**  
   Set up the `gh` CLI authentication:

   ```bash
   # Define your GitHub token
   GH_TOKEN='Your_TOKEN_here'
   echo ${GH_TOKEN} | gh auth login --with-token
   gh auth status

   # Configure with your github credentials
   gh auth setup-git
   ```

2. **Create a New Repository**  
   Use the `gh` CLI to create a new repository:

   ```bash
   # Find your GitHub username
   username=$(gh api user --jq '.login')

   # Define repository name and visibility
   repo_name='sample-project-b2b'
   repo_visibility='public'

   # Create a new public repository
   gh repo create ${username}/${repo_name} --${repo_visibility}
   ```

3. **Initialize a Git Repository and Commit Files**  
   Navigate to your project folder and initialize the repository:

   ```bash
   # Define project folder path and user details
   project_folder='sample-project-1'
   git_email="sample@example.com"
   git_user="sample-user"

   # Go to the project folder
   cd ${project_folder}/
   git init
   git add .
   git config --global user.email "${git_email}"
   git config --global user.name "${git_user}"
   git commit -m "Stage Project Files"
   ```

4. **Set Up the CI/CD Workflow**  
    Create the required directory and move the workflow file:

    ```bash
    # Create .github/workflows directory and move the workflow file
    mkdir -p .github/workflows/
    mv ci-demo.yml .github/workflows/
    
    # Define remote repository URL
    remote_url="https://github.com/${username}/${repo_name}.git"
    git add .github/workflows/ci-demo.yml
    git commit -m "Add GitHub Actions workflow for Terraform"
    git branch -M main
    git remote add origin ${remote_url}
    git push origin main
    ```

5. **Set Up GitHub Repository Secrets**  
   Use `gh` CLI to add the required secrets for the workflow to authenticate with AWS:

   ```bash
   # Define your secrets
   aws_access_key='YOUR_AWS_ACCESS_KEY'
   aws_secret_access_key='YOUR_AWS_SECRET_ACCESS_KEY'

   # Set secrets in the GitHub repository for a specific environment (e.g., test)
   environment_name='test'
   gh secret set AWS_ACCESS_KEY_ID --env ${environment_name} --body "${aws_access_key}"
   gh secret set AWS_SECRET_ACCESS_KEY --env ${environment_name} --body "${aws_secret_access_key}"
   ```

7. **Trigger the Pipeline**  
   Make a sample commit to trigger the pipeline:

   ```bash
   # Make a sample change to trigger the pipeline
   # Stage those changes
   # Commit those changes
   # Push those changes to view everything in action
   ```

7. **Monitor the Workflow**  
   Go to the **Actions** tab in your GitHub repository to view the status of the workflow.

8. **View Running Pipeline**  
   Go to the **Actions** tab in your GitHub repository to view the running pipeline and monitor the creation of resources (e.g., Lambda functions) in your AWS cloud environment.

9. **CleanUp Steps**
   Remove the test repository using gh cli:

   ```bash
   gh repo delete $remote_url --yes
   ``` 
