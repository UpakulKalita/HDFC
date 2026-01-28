allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
<<<<<<< HEAD
    if (path != ":app") {
        project.evaluationDependsOn(":app")
    }
=======
    project.evaluationDependsOn(":app")
>>>>>>> 439ddb8cea7c8238ea1b458e68168840ccc34272
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
