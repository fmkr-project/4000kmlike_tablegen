(ql:quickload :cl-csv)

(setq cl-csv:*separator* #\;)
(defvar out-loc #p"../4000kmlike_tablegen/out.md")    ;TODO correct this

(if (probe-file out-loc) (delete-file out-loc))

(print "absolute input path (csv): ")
(defvar filein-path (read-line))
(defvar filein (cl-csv:read-csv (pathname filein-path)))

(with-open-stream (res (open out-loc :direction :output :if-exists :supersede))
  (write-string "|From (km) |To (km) | Fare|" res)
  (terpri res)
  (write-string "|:--------:|:------:|:---:|" res)
  (terpri res)
  (loop for line in filein
     do (write-char #\| res)
     do (loop for item in line
	   do (write-string item res)
	   do (write-char #\| res))
     do (terpri res)))
