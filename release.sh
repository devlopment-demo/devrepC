#!/bin/bash

# List of environments
environments=("dev" "qa" "stage" "prod")

# Loop through environments
for env in "${environments[@]}"
do
    if [ "$env" == "dev" ]
    then
        # Update JAR file for dev environment
        sed -i "s/<replace_with_dev_values>/g" app.properties
    elif [ "$env" == "qa" ]
    then
        # Update JAR file for qa environment
        sed -i "s/<replace_with_qa_values>/g" app.properties
    elif [ "$env" == "stage" ]
    then
        # Update JAR file for stage environment
        sed -i "s/<replace_with_stage_values>/g" app.properties
    elif [ "$env" == "prod" ]
    then
        # Update JAR file for prod environment
        sed -i "s/<replace_with_prod_values>/g" app.properties
    fi

    # Build and deploy the JAR file for the current environment
    awk -v env="$env" '{gsub(/<env>/,env);print}' Dockerfile.template > Dockerfile
    docker build -t myapp:$env .
    docker run -d myapp:$env
done
