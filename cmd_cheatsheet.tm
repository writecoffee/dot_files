<TeXmacs|1.0.7.19>

<style|generic>

<\body>
  <\itemize>
    <item><with|font-shape|small-caps|Grep>

    <\enumerate>
      <item>Find file(s) under DIR with PATTERN matched

      <with|font-family|tt|ls DIR \| grep PATTERN>
    </enumerate>

    <item><with|font-shape|small-caps|Find>

    <\enumerate>
      <item>Find file(s) under DIR recursively with PATTERN matched

      <with|font-family|tt|find DIR -file PATTERN>

      <item>List all files under DIR showing size, modification date, and etc

      <with|font-family|tt|find DIR -type f -ls>
    </enumerate>

    <item><with|font-shape|small-caps|Sort>

    <\enumerate>
      <item>Find union/intersect/different set between FILE_1 and FILE_2.

      <\with|font-family|tt>
        cat FILE_1 FILE_2 \| sort \| uniq \<gtr\> OUTPUT
      </with>

      <with|font-family|tt|cat FILE_1 FILE_2 \| sort \| uniq -d \<gtr\>
      OUTPUT>

      <with|font-family|tt|cat FILE_1 FILE_2 \| sort \| uniq -u \<gtr\>
      OUTPUT>

      <item>
    </enumerate>
  </itemize>
</body>

<\initial>
  <\collection>
    <associate|page-type|letter>
  </collection>
</initial>