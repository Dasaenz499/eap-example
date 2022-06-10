pipeline {


  agent {
      label "maven"
  }

 

  stages {

    stage("Checkout Source Code") {
      steps {
        echo "Init Checkout Source Code"
        checkout scm
        echo "end Checkout Source Code"
      }
    }


    stage("Build") {
      steps {
        echo "Init Build"



                sh "mvn clean compile package -DskipTests "




        echo "End Build"
      }
    }
    
    stage("Deploy Dev") {

      steps {
        script {
          echo "Init Build Image"
         
            openshift.withCluster() {
              openshift.verbose()
              openshift.withProject("dev-environment") {
                openshift.selector("bc", "mysample").startBuild("--from-file=./target/helloworld-html5.war", "--wait=true")
              }
            }
          
          echo "End Build Image"
        }
      }
    }
    
    
    stage("Deploy QA") {

      steps {
        script {
          echo "Init Build Image"
         
            openshift.withCluster() {
              openshift.verbose()
              openshift.withProject("qa-environment") {
                openshift.selector("bc", "mysample").startBuild("--from-file=./target/helloworld-html5.war", "--wait=true")
              }
            }
          
          echo "End Build Image"
        }
      }
    }
    
     stage("Deploy Prod") {

      steps {
        script {
          echo "Init Build Image"
         
            openshift.withCluster() {
              openshift.verbose()
              openshift.withProject("prod-environment") {
                openshift.selector("bc", "mysample").startBuild("--from-file=./target/helloworld-html5.war", "--wait=true")
              }
            }
          
          echo "End Build Image"
        }
      }
    }
    
    
  }
}

