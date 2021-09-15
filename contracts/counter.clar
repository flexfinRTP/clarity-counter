;; Counter contract
;; - count-up function that can be called by the contract owner.
;; - get-count function that is going to return the current counter value.

(define-constant contract-owner tx-sender) ;; constant does not change, 2 parameters, who is tx-sender=contract-owner

(define-data-var counter uint u0) ;;name of var, type, initial value

(define-read-only (get-count) ;;read-only doesn't have to send transaction to get value, cant change state
    (var-get counter) ;; get init value of counter =(u0)
)

;; on clarinet console int terminal
;; (contract-call? 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.counter get-count)
;; u0

(define-public (count-up)
    (begin
        (asserts! (is-eq tx-sender contract-owner) (err false)) ;;is tx-sender=contract-owner?
        (ok (var-set counter (+ (get-count) u1)))
    )
)

;;CHALLENGE - refactor code to keep counter for EVERY sender that calls into it
;;create private counter for each principal