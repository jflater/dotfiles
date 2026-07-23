# Run the Streamlit app in the current directory using its venv (local testing, no snow deploy)
alias snow_deploy_local='.venv/bin/streamlit run app.py'

# Deploy the current Streamlit app to Snowflake (overwrites existing)
alias snow_deploy_dev='snow streamlit deploy --replace -c lcs_dev'
alias snow_deploy_test='snow streamlit deploy --replace -c lcs_test'

# Deploy to PROD — requires 'confirm' arg to actually run, e.g.: snow_deploy_prod confirm
snow_deploy_prod() {
    if [ "$1" != "confirm" ]; then
        echo "Refusing to deploy to PROD without confirmation."
        echo "Usage: snow_deploy_prod confirm"
        return 1
    fi
    snow streamlit deploy --replace -c lcs_prod
}

# Directory tree (2 levels, colorized, no hidden files)
alias t='tree -C -L 2 -I "__pycache__|*.pyc|.git"'
