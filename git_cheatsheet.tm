<TeXmacs|1.0.7.19>

<style|generic>

<\body>
  <doc-data|<doc-title|<with|font-shape|small-caps|Git Cheatsheet>>>

  <\itemize>
    <item><with|font-shape|small-caps|The Index, Commit and Workspace>

    Every git repository has a special storage area, known as the index. When
    you <with|font-family|tt|git add> something, it copies the contents of
    the specified files into the index. So, if you change the file again
    after <with|font-family|tt|git add>, and then commit, the new changes
    won't be included.

    The index is often referred to as <with|font-shape|italic|stage>. Because
    you can think of it as a <with|font-shape|italic|staging area> for a new
    commit. <with|font-family|tt|git add> is used when you've modified a
    file, or created a new file. In either case, it updates the index with a
    new file version.

    Running <with|font-family|tt|git commit> creates a new commit with a copy
    of the index.

    <\equation*>
      <matrix|<tformat|<table|<row|<cell|<text|Commit>>>>>>
      \<leftrightarrow\> <matrix|<tformat|<table|<row|<cell|<text|Index>>>>>>
      \<leftrightarrow\> <matrix|<tformat|<table|<row|<cell|<text|Workspace>>>>>>
    </equation*>

    Ways to spell <with|font-family|tt|commit>:

    <with|font-base-size|9|<tabular|<tformat|<table|<row|<cell|Parent commit
    of mainline>|<cell|<with|font-family|tt|mainline^>>>|<row|<cell|Second
    parent (for a merge)>|<cell|<with|font-family|tt|mainline^2>>>|<row|<cell|Great-grand
    parent of a mainline>|<cell|<with|font-family|tt|mainline^3>>>|<row|<cell|Previous
    position of mainline>|<cell|<with|font-family|tt|mainline@{1}>>>|<row|<cell|Where
    mainline was yesterday>|<cell|<with|font-family|tt|mainline@{yesterday}
    or mainline@{24 hours ago}>>>|<row|<cell|This branch's upstream
    branch>|<cell|<with|font-family|tt|@{upstream} or
    @{u}>>>|<row|<cell|Newest commit with ``test'' or ``spec'' in the
    description>|<cell|<with|font-family|tt|:/test\|spec>>>>>>>

    <\itemize>
      <item>Show Diff between Index and Commit

      <with|font-family|tt|git diff --stage>

      <item>Unadd and Undo

      <with|font-family|tt|git reset HEAD \<less\>file\<gtr\>>

      <with|font-family|tt|git checkout \<less\>file\<gtr\>>

      <item>Consider Each Change We Made to the File

      <with|font-family|tt|git diff --word-diff>

      <with|font-family|tt|git add --patch>
    </itemize>

    <item><with|font-shape|small-caps|Rebase>

    <\itemize>
      <item>Reverse the Action Performed Prior to the Rebase

      <with|font-family|tt|git reflog>

      <with|font-family|tt|git reset --hard HEAD@{#}>
    </itemize>
  </itemize>
</body>

<\initial>
  <\collection>
    <associate|page-type|letter>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?>>
  </collection>
</references>