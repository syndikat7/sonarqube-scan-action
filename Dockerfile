FROM sonarsource/sonar-scanner-cli:4.6
ARG JDK_PATH=/usr/lib/jvm/java-11-openjdk/jre
ARG CERT_FOLDER=/certs

LABEL version="1.0.0" \
      repository="https://github.com/sonarsource/sonarqube-scan-action" \
      homepage="https://github.com/sonarsource/sonarqube-scan-action" \
      maintainer="SonarSource" \
      com.github.actions.name="SonarQube Scan" \
      com.github.actions.description="Scan your code with SonarQube to detect Bugs, Vulnerabilities and Code Smells in up to 27 programming languages!" \
      com.github.actions.icon="check" \
      com.github.actions.color="green"

# https://help.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions#user
USER root

# Add certificates
COPY certs /certs
# Execute this command for any crt within the certs folder if you have multiple
RUN ${JDK_PATH}/bin/keytool -import -alias sonar -cacerts -storepass changeit -noprompt -keystore ${JDK_PATH}/lib/security/cacerts -file ${CERT_FOLDER}/sonar.crt

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
