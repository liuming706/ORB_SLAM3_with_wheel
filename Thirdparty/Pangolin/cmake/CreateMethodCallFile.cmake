macro(CreateMethodCallFile filename namespace function symbols)
  file(
    WRITE ${filename}
    "// CMake generated file. Do Not Edit.\n\n#pragma once\n\nnamespace ${namespace} {\n\n"
  )
  foreach(symbol ${symbols})
    file(APPEND ${filename} "void ${symbol}();\n")
  endforeach()
  file(APPEND ${filename} "\ninline bool ${function}()\n{\n")
  foreach(symbol ${symbols})
    file(APPEND ${filename} "    ${symbol}();\n")
  endforeach()
  file(APPEND ${filename} "    return true;\n}\n\n} // ${namespace}\n")
endmacro()
