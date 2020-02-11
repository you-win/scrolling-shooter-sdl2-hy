(defmacro super-init [&rest args]
    `(-> (super) (.--init-- ~@args)))

(defmacro get-value [^dict dict key default]
    `(do (if (in ~key ~dict) (get ~dict ~key)
        (else (~@default)))))
