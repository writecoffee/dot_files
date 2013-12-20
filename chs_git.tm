Git Cheatsheet


1 The Index, Commit and Workspace 
Every git repository has a special storage area, known as the index. When you git add something, it copies the contents of the specified files into the index. So, if you change the file again after git add, and then commit, the new changes won't be included.
The index is often referred to as stage. Because you can think of it as a staging area for a new commit. git add is used when you've modified a file, or created a new file. In either case, it updates the index with a new file version.
Running git commit creates a new commit with a copy of the index.
(
Commit
) <leftrightarrow> (
Index
) <leftrightarrow> (
Workspace
) 
<bullet>  Ways to Spell commit
Parent commit of mainline                                  mainline^
Second parent (for a merge)                                mainline^2
Great-grand parent of a mainline                           mainline^3
Previous position of mainline                              mainline@{1}
Where mainline was yesterday                               mainline@{yesterday} or mainline@{24 hours ago}
This branch's upstream branch                              @{upstream} or @{u}
Newest commit with ``test'' or ``spec'' in the description :/test|spec

<bullet>  Show Diff between Index and Commit
git diff --stage
<bullet>  Unadd and Undo
git reset HEAD <less>file<gtr>
git checkout <less>file<gtr>
<bullet>  Consider Each Change We Made to the File
git diff --word-diff
git add --patch 
