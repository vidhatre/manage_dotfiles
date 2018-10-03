# Issues with using python, packaging, pip, or python scripts

### python error: "RuntimeError: module compiled against API version 0xc but this version of numpy is 0xb"
- weird interaction between python packages: pandas, numpy, and anythig that depends on the two.
- was able to quickly reproduce with:
  ```  
    python -m "import pandas"
  ```
- using pipdeptree listed the packages and their dependencies, found that matplotlib depends on the two
- so did uninstall:
  ```  
    pip uninstall matplotlib pandas numpy
  ```
- then install without caching(to force download of packages even if in cache):
  ```
     pip install -r requirements.txt --no-cache-dir
  ```

