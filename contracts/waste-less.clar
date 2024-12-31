;; WasteLess Protocol
;; Connects restaurants with food banks to reduce food waste

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_NOT_AUTHORIZED (err u1001))
(define-constant ERR_INVALID_AMOUNT (err u1002))
(define-constant ERR_LISTING_NOT_FOUND (err u1003))

;; Data vars
(define-data-var min-donation-amount uint u1)

;; Maps
(define-map food-listings
    uint
    {
        restaurant: principal,
        food-type: (string-utf8 50),
        quantity: uint,
        expiry: uint,
        claimed: bool
    }
)

(define-map restaurant-stats
    principal
    {
        total-donations: uint,
        reputation-score: uint
    }
)

(define-data-var listing-nonce uint u0)

;; Public functions
(define-public (create-food-listing (food-type (string-utf8 50)) (quantity uint) (expiry uint))
    (let
        (
            (listing-id (var-get listing-nonce))
        )
        (asserts! (> quantity u0) ERR_INVALID_AMOUNT)
        (map-set food-listings listing-id {
            restaurant: tx-sender,
            food-type: food-type,
            quantity: quantity,
            expiry: expiry,
            claimed: false
        })
        (var-set listing-nonce (+ listing-id u1))
        (ok listing-id)
    )
)

(define-public (claim-food-listing (listing-id uint))
    (let
        (
            (listing (unwrap! (map-get? food-listings listing-id) ERR_LISTING_NOT_FOUND))
        )
        (asserts! (not (get claimed listing)) ERR_LISTING_NOT_FOUND)
        (map-set food-listings listing-id (merge listing { claimed: true }))
        (update-restaurant-stats (get restaurant listing))
        (ok true)
    )
)

;; Private functions
(define-private (update-restaurant-stats (restaurant principal))
    (let
        (
            (current-stats (default-to { total-donations: u0, reputation-score: u0 }
                (map-get? restaurant-stats restaurant)))
        )
        (ok (map-set restaurant-stats restaurant 
            (merge current-stats { 
                total-donations: (+ (get total-donations current-stats) u1),
                reputation-score: (+ (get reputation-score current-stats) u10)
            })
        ))
    )
)

;; Read-only functions
(define-read-only (get-listing (listing-id uint))
    (map-get? food-listings listing-id)
)

(define-read-only (get-restaurant-stats (restaurant principal))
    (map-get? restaurant-stats restaurant)
)