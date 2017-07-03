# Basic file paths and file configuraiton fot the project directory

projectDir=paste0(Sys.getenv("HOME"),"/",".project_config")
projectListFile=paste0 (projectDir,"/","project_list.csv")
projectFileHeader<-data.frame(list("Project_Name","Project_File"))


#####################################################################
load_project_list <- function() {
  #if (file.exists(projectListFile) & file.mode(projectDir)==as.octmode(700) ) {
      # ToDo enforce file permissions
  if (file.exists(projectListFile)) {
    myProjectList <- read.csv(projectListFile,header = TRUE, stringsAsFactors=FALSE)
  } else { warning ("File does not exist")}
  myProjectList
}

#####################################################################
load_project_config <- function (pname) {
  #print (pname)
  if (exists("projectList")) {
    myProjectList <- projectList
  } else {
    myProjectList <- load_project_list()
  }
  #print (myProjectList)
  #myProjectFile <- paste0(projectDir,"/",pfile)
  if ( pname %in% myProjectList) {
    pfile <- myProjectList$Project_File[myProjectList$Project_Name==pname]
    pfile <- paste0(projectDir,"/",pfile)
    print (pfile)
    if (file.exists((pfile))) {
      projectConfig <- read.csv(pfile,header = TRUE, stringsAsFactors=FALSE)
    } else {
      warning (paste0 (pfile," file does not exist"))
    }
  } else {
    warning (paste0 (pname," project does not exist"))
  }
  return (projectConfig)
}

#####################################################################
add_key_value <- function (pname, key, value) {

}
#####################################################################
create_project <- function(pname="blankproject",pfile="blankfile") {


  if (exists("projectList")) {
    myProjectList <- projectList
  } else {
    myProjectList <- load_project_list()
  }

  myProjectFile <- paste0(projectDir,"/",pfile)
  if ( pname %in% myProjectList) {
    print (pname)
    if ( !file.exists(myProjectFile)) {
    #print (pfile)
    myProjectList <- rbind(myProjectList,list(pname,pfile))
    write.csv(file=projectListFile,myProjectList,row.names = FALSE)
    Sys.chmod(projectListFile, mode = "0600")

    #Duplicate code need to move to function
    bootstrapProject <- data.frame(list("some","data"))
    colnames(bootstrapProject) <- list("key", "value")
    write.csv(file=myProjectFile,bootstrapProject,row.names = FALSE)
    Sys.chmod(myProjectFile, mode = "0600")

    } else {
      warning (paste0 (pfile," exists"))
      return (myProjectList)
    }
  } else {
    warning (paste0( pname, " exists"))
    return (myProjectList)
  }

  return(myProjectList)
}

#############################################################
delete_project <- function () {

}

#############################################################
init_config_dir <- function (force=FALSE) {
  if (!dir.exists(projectDir)) {
    dir.create(projectDir,mode="0700")
  }

  #Populate a dummy project list file
  if (!file.exists(projectListFile)) {
    #write("Project_Name,Project_File",file=projectListFile)
    bootstrapList <- data.frame(list("test","test.csv"))
    colnames(bootstrapList) <- list("Project_Name", "Project_File")
    write.csv(file=projectListFile,bootstrapList,row.names = FALSE)
    Sys.chmod(projectListFile, mode = "0600")

  }

  #populate a dummy project file
  myProjectFile = paste0(projectDir,"/","test.csv")
  if (!file.exists(myProjectFile)) {
    bootstrapProject <- data.frame(list("some","data"))
    colnames(bootstrapProject) <- list("key", "value")
    write.csv(file=myProjectFile,bootstrapProject,row.names = FALSE)
    Sys.chmod(myProjectFile, mode = "0600")
  }
}



#############
#Main
#Always load in the project list at the start
#projectList <- load_project_list()
