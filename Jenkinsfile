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



                sh "mvn clean compile -DskipTests "




        echo "End Build"
      }
    }
    
  }
}
