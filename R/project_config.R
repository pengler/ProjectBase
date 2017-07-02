# Basic file paths and file configuraiton fot the project directory

projectDir=paste0(Sys.getenv("HOME"),"/",".project_config")
projectListFile=paste0 (projectDir,"/","project_list.csv")
projectFileHeader<-data.frame(list("Project_Name","Project_File"))


load_project_list <- function() {
  if (file.exists(projectListFile) & file.mode(projectDir)==as.octmode(700) ) {
    myProjectList <- read.csv(projectListFile,header = TRUE)
  } else { warning ("File does not exist or has incorrect permissions")}
  myProjectList
}

load_project_config <- function () {

}

create_project <- function(pname="blank",pfile="blank") {
  if (exists(projectList)) {
    myProjectList <- projectList
  } else {
    myProjectList <- load_project_list()
  }

  rbind(myProjectList,list(pname,pfile))
  myProjectList
}

delete_project <- function () {

}

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
