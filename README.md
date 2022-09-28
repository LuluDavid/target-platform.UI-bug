# target-platform.UI-bug

This is a sample project that exposes a UI bug in Eclipse Target Platform configuration.  
To test it, just run:
```bash
./test/test.sh
```
Which should compile fine.  
  
Then, open [Eclipse 2022-03 for Eclipse committers](https://www.eclipse.org/downloads/packages/release/2022-03/r/eclipse-ide-eclipse-committers) 
(any Java 17 compatible Eclipse should work fine actually), File -> Import -> Existing Projects into Workspace -> Browse /path/to/target-platform.UI-bug,
tick "Search for nested projects", "Select All" (parent, target & test) & "Finish".  
Finally, Project -> Clean, "Clean All Projects" & "Clean", Right Click One project, Maven -> Update Project, "Select All" & "Ok", open target/test.target.target
& Set As Active Target Platform.  
You will observe that contrarily to CLI, edu.ucar:cdm (5.1.0) is resolved but not edu.ucar:d4lib (5.5.3), as repositories is not specified for the second one.
If you go to target platform source, add the \<repositories\> tag for d4lib & reload the platform, it will successfully resolve this dependency too.
