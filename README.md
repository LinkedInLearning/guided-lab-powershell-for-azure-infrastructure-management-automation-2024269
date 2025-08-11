# Guided Lab: PowerShell for Azure Infrastructure Management Automation
This is the repository for the LinkedIn Learning course `Guided Lab: PowerShell for Azure Infrastructure Management Automation`. The full course is available from [LinkedIn Learning][lil-course-url].

![lil-thumbnail-url]

## Course Description

Are you just getting started on your journey as an IT professional working with PowerShell? In this hands-on project-based course, join Microsoft MVP Jess Pomfret as she outlines essential PowerShell skills for creating and managing infrastructure in Azure. Discover what PowerShell is and why it's so important in an IT professional’s toolbelt. Along the way, Jess demonstrates how to test with Pester and generate documentation with ImportExcel to deliver comprehensive infrastructure management solutions. As you progress throughout the course, you’ll get a chance to build your own project and practice your new PowerShell skills.

_See the readme file in the main branch for updated instructions and information._
## Instructions
This repository has branches for each of the videos in the course. You can use the branch pop up menu in github to switch to a specific branch and take a look at the course at that stage, or you can add `/tree/BRANCH_NAME` to the URL to go to the branch you want to access.

## Branches
The branches are structured to correspond to the videos in the course. The naming convention is `CHAPTER#_MOVIE#`. As an example, the branch named `02_03` corresponds to the second chapter and the third video in that chapter. 
Some branches will have a beginning and an end state. These are marked with the letters `b` for "beginning" and `e` for "end". The `b` branch contains the code as it is at the beginning of the movie. The `e` branch contains the code as it is at the end of the movie. The `main` branch holds the final state of the code when in the course.

When switching from one exercise files branch to the next after making changes to the files, you may get a message like this:

    error: Your local changes to the following files would be overwritten by checkout:        [files]
    Please commit your changes or stash them before you switch branches.
    Aborting

To resolve this issue:
	
    Add changes to git using this command: git add .
	Commit changes using this command: git commit -m "some message"


## Instructor

Jess Pomfret

Database Platform Architect and Microsoft MVP
              

Check out my other courses on [LinkedIn Learning](https://www.linkedin.com/learning/instructors/jess-pomfret?u=104).


[0]: # (Replace these placeholder URLs with actual course URLs)

[lil-course-url]: https://www.linkedin.com/learning/guided-lab-automating-azure-infrastructure-management-with-powershell
[lil-thumbnail-url]: https://media.licdn.com/dms/image/v2/D560DAQEBVCkusLDoKg/learning-public-crop_675_1200/B56ZiBg9waG4AY-/0/1754519559915?e=2147483647&v=beta&t=vsKLMZcbCPnIyqiNOOVTN9htAMs70qRW8WWFQa6voh8
