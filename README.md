# LAB0B - Tools of the Trade (Development Tools)

_A quick blurb or sub-title text_

## Background

Before proceeding with this lab, the student should take the time to read

* this
* that 
* and the other thing

## Objectives

* Continue using `git` to
  * clone repositories
  * create `develop` branches within in which to do your work
  * commit changes to your source code (updates, file creation and/or deletion)
  * publish your `develop` branch to GitHub
* Learn to build executables (targets) using
  * C++ source files using Visual Studio command line development tools (e.g., `CL`)
  * build systems like `make`
  * Learn to build executables (targets) using "meta" build systems like `cmake`

## Assumptions

The following applications are assumed to be installed and configured on your system:

* Visual Studio (configured to build C++ applications)
  * 
* CMake
* Git
* GitHub CLI
* Developer Powershell for VS 2022

## Getting Started

After accepting this assignment with the provided [GitHub Classroom Assignment link](https://classroom.github.com/fill-me-in), clone this repository. If you have cloned the repository from the command line prompt, navigate into the newly created directory

```bash
cd labn-github-username
```

Next, create a branch named `develop`. Please note: The name of this branch **must** be as specified and will be, to the grading scripts, case-sensitive.

```bash
git checkout -b develop
```

Make sure you are on the `develop` branch before you get started. Make all your commits on the `develop` branch.

```bash
git status
```

_You may have to type the `q` character to get back to the command line prompt after viewing the status._

## Tasks

This lab consists of three tasks, i.e., use

1. the Visual Studio command line development tools to build targets from C++ source files and dependencies.
1. `nmake` to dictate the build process.
1. `cmake` to dictate the build process.

### Task 1: Compiling C++ Source Code with `CL`

* Organizing our code
* Compiling (things the compiler needs to know)
* Specifying where to look for local include files
* Specifyng a target name

Below is an example of using `Powershell`, as instantiated by the `Visual Studio 2022 > Developer Powershell for VS 2022`. Note, the directory path for you instance will differ accordingly. Basically, `C:\Path\To\Your\lab0b` is the directory in which you cloned `lab0b` (this lab). Be sure to change into that directory's `src` folder after opening the `Developer Powershell for VS 2022` before attempting the following commands.

```Powershell
PS C:\Path\To\Your\lab0b\src> CL /EHsc /I ..\include .\main.cpp
Microsoft (R) C/C++ Optimizing Compiler Version 19.30.30709 for x86
Copyright (C) Microsoft Corporation.  All rights reserved.

main.cpp
Microsoft (R) Incremental Linker Version 14.30.30709.0
Copyright (C) Microsoft Corporation.  All rights reserved.

/out:main.exe
main.obj
PS C:\Path\To\Your\lab0b\src>
```

Several things just happened here. You source code was compiled, creating an object file for the code your wrote in C++. This object code makes references to other libraries (e.g., `iostream`). These external libraries are used to create additional object files. Finally, to build an executable program, a program known as a "Linker" is used to "link" all these object files into a single executable file for the target operating system. You can see these new files (`main.obj` and `main.exe`, the object file and executable, respectively, for our "main" target. The use of the phrase "main target" is meant to reference this `main.exe` executable).

By the way, the reason we specify the `/EHsc` switch for `CL` is because of this warning, which you may get if you do not specify `/EHsc` as it so indicates.

```Powershell
C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Tools\MSVC\14.30.30705\include\ostream(743): warning C4530: C++ exception handler used, but unwind semantics are not enabled. Specify /EHsc
```

Use the `ls` command to see these new files:

```Powershell
PS C:\Path\To\Your\lab0b\src> ls


    Directory: C:\Path\To\Your\lab0b\src


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----         1/24/2022   8:39 PM           1168 demo.cpp
-a----         1/24/2022   8:39 PM           1168 main.cpp
-a----         1/24/2022   9:11 PM         194048 main.exe
-a----         1/24/2022   9:11 PM         138258 main.obj
```

Now that you have successfully built a target (an executable), let's execute this new target:

```Powershell
PS C:\Path\To\Your\lab0b\src> .\main.exe
Hello, Lab0a Main Target!
Could not open "main_data.txt"
```

We see that the program apparently failed to open some file named `main_data.txt`. In fact, it was expecting this file to exist as the same directory as the executable itself. Looking at the output of the `ls` command above, we see that's true. No such file currently exists in this folder. The files do exist, however, in another location, i.e., in the `resource` folder of this project. Let's copy those files here, take a quick peek to see they now exists and try to run the program again.

```Powershell
PS C:\Path\To\Your\lab0b\src> cp ..\resource\main_data.txt .
PS C:\Path\To\Your\lab0b\src> cp ..\resource\demo_data.txt .
PS C:\Path\To\Your\lab0b\src> ls


    Directory: C:\Path\To\Your\lab0b\src


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----         1/24/2022   8:39 PM           1168 demo.cpp
-a----         1/24/2022   8:39 PM              0 demo_data.txt
-a----         1/24/2022   8:39 PM           1168 main.cpp
-a----         1/24/2022   9:11 PM         194048 main.exe
-a----         1/24/2022   9:11 PM         138258 main.obj
-a----         1/24/2022   8:39 PM              0 main_data.txt


PS C:\Path\To\Your\lab0b\src> .\main.exe
Hello, Lab01a Main Target!
Successfully opened "main_data.txt"... will now close this file
PS C:\Path\To\Your\lab0b\src>
```

One last thing that we should cover has to do with naming a specific target. What if you don't want the program that's built using `main.cpp` (and it's dependencies) to be named `main.exe`? Is there a way to specify a different name? Yes, there is. What about the object files? Yes, that too.

Follow along.

```Powershell
PS C:\Path\To\Your\lab0b\src> CL /EHsc /I ..\include .\main.cpp /link /out:lab0b.exe
Microsoft (R) C/C++ Optimizing Compiler Version 19.30.30709 for x86
Copyright (C) Microsoft Corporation.  All rights reserved.

main.cpp
Microsoft (R) Incremental Linker Version 14.30.30709.0
Copyright (C) Microsoft Corporation.  All rights reserved.

/out:main.exe
/out:lab0b.exe
main.obj
PS C:\Path\To\Your\lab0b\src> ls


    Directory: C:\Path\To\Your\lab0b\src


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----         1/24/2022   9:54 PM           1168 demo.cpp
-a----         1/24/2022   8:39 PM              0 demo_data.txt
-a----         1/24/2022  10:13 PM         199168 lab0b.exe
-a----         1/24/2022   9:54 PM           1168 main.cpp
-a----         1/24/2022  10:13 PM         167286 main.obj
-a----         1/24/2022   8:39 PM              0 main_data.txt
-a----         1/24/2022   8:39 PM              0 test_data.txt


PS C:\Path\To\Your\lab0b\src>
```

In the above, we see that we indeed created an executable named `lab0b.exe`, but the object file is still named `main.obj`. To change the name of the generated intermediate object file, we use the `/Fo` switch for `CL` as follows:

```Powershell
PS C:\Path\To\Your\lab0b\src> CL /Fo.\lab0b.obj /EHsc /I ..\include .\main.cpp /link /out:lab0b.exe
Microsoft (R) C/C++ Optimizing Compiler Version 19.30.30709 for x86
Copyright (C) Microsoft Corporation.  All rights reserved.

main.cpp
Microsoft (R) Incremental Linker Version 14.30.30709.0
Copyright (C) Microsoft Corporation.  All rights reserved.

/out:lab0b.exe
/out:lab0b.exe
.\lab0b.obj
PS C:\Path\To\Your\lab0b\src> ls


    Directory: C:\Path\To\Your\lab0b\src


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----         1/24/2022   9:54 PM           1168 demo.cpp
-a----         1/24/2022   8:39 PM              0 demo_data.txt
-a----         1/24/2022  10:18 PM         199168 lab0b.exe
-a----         1/24/2022  10:18 PM         167290 lab0b.obj
-a----         1/24/2022   9:54 PM           1168 main.cpp
-a----         1/24/2022  10:13 PM         167286 main.obj
-a----         1/24/2022   8:39 PM              0 main_data.txt
-a----         1/24/2022   8:39 PM              0 test_data.txt


```

Ok, you have just been guided through the process of compiling, linking and executing a specified target. Now it's your turn:

Use what you just learned to build and execute the following targets:

1. `lab0b-demo.exe` built with the `demo.cpp` source file (which has similar dependencies as `main.cpp`)

### Task 2 - Using `nmake` to build targets

Recall what it takes to build an executable built by just a simple file source file and local header file:

```Powershell
PS C:\Path\To\Your\lab0b\src> CL /Fo.\lab0b.obj /EHsc /I ..\include .\main.cpp /link /out:lab0b.exe
```

All these command line switches are confusing, not easy to remember, and prone to user input error. It would be nice if we could capture this command, or the steps that lead to its final product, in a single file and issue one simple command to build some target. Guess what. There is.

1. Create a new file named `Makefile` in the `C:\Path\To\Your\lab0b\src`:

   ```Powershell
   PS C:\Path\To\Your\lab0b\src> notepad .\Makefile
   ```

   This will launch the Notepad editor. 
   
1. Enter the following, using the tab character for indentation:

   ```Makefile
   lab0b.exe: lab0b.obj
        LINK lab0b.obj
   lab0b.obj: main.cpp
        CL /Fo.\lab0b.obj /EHsc /I ..\include -c main.cpp
   ```

   when you are done, save your file and close Notepad. Because Notepad automatically adds the `txt` extension to files it creates, we need to rename `Makefile.txt` to `Makefile`. This is done with the `mv` command (move):

   ```Powershell
   PS C:\Path\To\Your\lab0b\src> mv Makefile.txt Makefile
   ```

1. Next run `nmake`:

   ```Powershell
   PS C:\Path\To\Your\lab0b\src> nmake

   Microsoft (R) Program Maintenance Utility Version 14.30.30709.0
   Copyright (C) Microsoft Corporation.  All rights reserved.

            CL /Fo.\lab0b.obj /EHsc /I ..\include -c main.cpp
   Microsoft (R) C/C++ Optimizing Compiler Version 19.30.30709 for x86
   Copyright (C) Microsoft Corporation.  All rights reserved.

   main.cpp
            LINK lab0b.obj
   Microsoft (R) Incremental Linker Version 14.30.30709.0
   Copyright (C) Microsoft Corporation.  All rights reserved.

   PS C:\Path\To\Your\lab0b\src> ls

            Directory: C:\Path\To\Your\lab0b\src


   Mode                 LastWriteTime         Length Name
   ----                 -------------         ------ ----
   -a----         1/24/2022   9:54 PM           1168 demo.cpp
   -a----         1/24/2022   8:39 PM              0 demo_data.txt
   -a----         1/24/2022  11:34 PM         199168 lab0b.exe
   -a----         1/24/2022  11:34 PM         167290 lab0b.obj
   -a----         1/24/2022   9:54 PM           1168 main.cpp
   -a----         1/24/2022   8:39 PM              0 main_data.txt
   -a----         1/24/2022  11:14 PM            114 Makefile
   -a----         1/24/2022   8:39 PM              0 test_data.txt


PS C:\Path\To\Your\lab0b\src>
```

As you can see, our `lab0b` object files and targets were created. By creating this `Makefile`, we've reduced our effort to creating targets to issuing just a single command: `nmake`

1. Modify the `Makefile` to prescribe the construction for the `lab0b-demo.exe` target like you did with `CL` in Part 1.
1. Test your new target construction plan by running `nmake` on a particular target:

   ```Powershell
   PS C:\Path\To\Your\lab0b\src> nmake lab0b-demo.exe

   Microsoft (R) Program Maintenance Utility Version 14.30.30709.0
   Copyright (C) Microsoft Corporation.  All rights reserved.

            CL /Fo.\lab0b-demo.obj /EHsc /I ..\include -c demo.cpp
   Microsoft (R) C/C++ Optimizing Compiler Version 19.30.30709 for x86
   Copyright (C) Microsoft Corporation.  All rights reserved.

    demo.cpp
            LINK lab0b-demo.obj
   Microsoft (R) Incremental Linker Version 14.30.30709.0
   Copyright (C) Microsoft Corporation.  All rights reserved.

   PS C:\Path\To\Your\lab0b\src>
   ```

   If modified correctly, then the output above should be similar to your output.

1. Finally, note that the first prescription planned in the `Makefile` is carried out now when `nmake` is run without specifying a target. That is, just run `nmake` by itself and note the target that's built.
1. Stage your `Makefile` for commit by typing `git add Makefile`.
1. Commit your new file by typing `git commit -m"Add Makefile."`
1. Push your changes to GitHub. If this is the first time you're pushing (i.e., publishing) the `develop` branch, then type `git push -u origin develop`, otherwise, just type `git push`


### Task 3 - Using cmake

## Submission Details

Before submitting your assignment, be sure you have pushed all your changes to GitHub. If this is the first time you're pushing your changes, the push command will look like:

```Powershell
git push -u origin develop
```

If you've already set up remote tracking (using the `-u origin develop` switch), then all you need to do is type

```Powershell
git push
```

As usual, prior to submitting your assignment on Blackboard, be sure that you have committed and pushed your final changes to GitHub. Once your final changes have been pushed, create a pull request that seeks to merge the changes in your `develop` branch into your `trunk` branch. Once your pull request has been created, submit the URL of your assignment _repository_ (i.e., _not_ the URL of the pull request) Blackboard using a **Text Submission**. Please note: the timestamp of the submission on Blackboard is used to assess any late penalties if and when warranted, _not_ the date/time you create your pull request. **No exceptions will be granted for this oversight**.

### Due Date

Your assignment submission is due by 11:59 PM, Friday, 28-Jan 2022.

### Grading Rubric

This assignment is worth **3 points**.

Criteria          | Exceeds Expectations        | Meets Expectations             | Below Expectations | Failure                                                 |
------------------|-----------------------------|--------------------------------|--------------------|---------------------------------------------------------|
Pull Request (20%)| Submitted early, correct url| Submitted on-time; correct url | Incorrect URL            | No pull request was created or submitted          |
Code Style (20%)  | Exemplary code style        | Consistent, modern coding style    | Inconsistent coding style| No style whatsoever or no code changes present|
Correctness^ (60%)| All unit tests pass         | At least 80% of the unit tests pass| At least 60% of the unit tests pass| Less than 50% of the unit tests pass|

^ _The Google Test unit runner, if configured, will calculate the correctness points based purely on the fraction of tests passed_.

### Late Penalty

* In the first 24 hour period following the due date, this lab will be penalized 0.6 point meaning the grading starts at 2.4 (out of 3 total possible) points.
* In the second 24 hour period following the due date, this lab will be penalized 1.2 points meaning the grading starts at 1.8 (out of 3 total possible) points.
* After 48 hours, the assignment will not be graded and thus earns no points, i.e., 0 out of 3 possible points.
