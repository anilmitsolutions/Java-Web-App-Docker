node('master')
{
	def mavenHome = tool name: "maven-3.6.3"

	properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')), pipelineTriggers([pollSCM('* * * * *')])])
	//echo "GitHub BranhName ${env.BRANCH_NAME}"
  	//echo "Jenkins Job Number ${env.BUILD_NUMBER}"
  	//echo "Jenkins Node Name ${env.NODE_NAME}"
  
  	echo "Jenkins Home ${env.JENKINS_HOME}"
  	echo "Jenkins URL ${env.JENKINS_URL}"
  	echo "JOB Name ${env.JOB_NAME}"
	stage('CheckOutCode')
	{
		git branch: 'development', credentialsId: 'e1d4f2f4-9158-47ff-9330-fcbd518951f8', url: 'https://github.com/anilmitsolutions/maven-web-application.git'
	}
	stage('Build')
	{
		sh "${mavenHome}/bin/mvn clean package"
	}
	stage('ExecuteSonarQubeReport')
	{
		sh "${mavenHome}/bin/mvn sonar:sonar"
	}
	stage('UploadArtifactIntoNexus')
	{
		sh "${mavenHome}/bin/mvn sonar:sonar"
	}
	stage('DeployApplicationIntoTomcatServer')
	{
		sshagent(['efbe4fda-e0fa-42cd-b810-44ec59d24879']) 
		{
    			sh "scp -o StrictHostKeyChecking=no target/maven-web-application.war ec2-user@13.232.88.92:/opt/apache-tomcat-9.0.37/webapps/"
		}	
	}
	stage('SendEmailNotification')
	{
		mail bcc: '', body: '''Build is Sucessfull.

		Regards,
		Anil M''', cc: 'anilm17394@gmail.com', from: '', replyTo: '', subject: 'Build is Successfulll', to: 'anilmit121@gmail.com'
	}
}
