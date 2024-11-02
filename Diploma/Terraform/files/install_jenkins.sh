#! /bin/bash

sudo apt install -y openjdk-17-jdk
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]  https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt -y update
sudo apt install -y jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# sleep 30 
# ADMIN_PASSWORD="123456"
# INITIAL_ADMIN_PWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
# echo "Jenkins Initial Admin Password: ${INITIAL_ADMIN_PWD}" > /tmp/jenkins_password

# JENKINS_CLI_JAR=/var/cache/jenkins/war/WEB-INF/jenkins-cli.jar
# if [ -f "$JENKINS_CLI_JAR" ]; then
#     java -jar "$JENKINS_CLI_JAR" -s http://localhost:8080/ -auth admin:${INITIAL_ADMIN_PWD} \
#     create-user --username admin --password $ADMIN_PASSWORD --fullname "Administrator" --email "admin@example.com"
# fi

# java -jar "$JENKINS_CLI_JAR" -s http://localhost:8080/ -auth admin:$ADMIN_PASSWORD \
# install-plugin git github -deploy
# java -jar "$JENKINS_CLI_JAR" -s http://localhost:8080/ -auth admin:$ADMIN_PASSWORD safe-restart
# EOF