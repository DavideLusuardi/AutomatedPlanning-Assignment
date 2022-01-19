;Header and description

(define (domain assignment3)

    ;remove requirements that are not needed
    (:requirements :strips :typing :numeric-fluents :negative-preconditions :durative-actions)

    (:types
        robot
        person
        crate
        location
        content
        carrier
    )

    ; un-comment following line if constants are needed
    ;(:constants )

    (:predicates
        (robot_at ?r - robot ?l - location)
        (person_at ?p - person ?l - location)
        (crate_at ?c - crate ?l - location)
        (carrier_at ?ca - carrier ?l - location)
        (contain ?c - crate ?co - content) ; assume contains only one content
        (available ?c - crate)
        (busy ?r - robot) ; TODO
        (need ?p - person ?co - content)
        (have ?p - person ?co - content)
        (load ?ca - carrier ?c - crate)
    )


    (:functions
        ; (full-capacity) - number
        (capacity ?ca - carrier) - number
        ; (cost) - number
    )

    (:durative-action pick-up
        :parameters (?r - robot ?ca - carrier ?c - crate ?l - location)
        :duration (= ?duration 2)
        :condition (and (over all (robot_at ?r ?l)) (over all (carrier_at ?ca ?l)) (at start (crate_at ?c ?l))
                            (at start (not (busy ?r))) (over all (available ?c)) (at start (> (capacity ?ca) 0)))
        :effect (and (at start (busy ?r)) (at end (not (busy ?r))) (at end (load ?ca ?c)) 
                (at start (decrease (capacity ?ca) 1)) (at start (not (crate_at ?c ?l))))
    )
    
    (:durative-action move-carrier
        :parameters (?r - robot ?ca - carrier ?l1 ?l2 - location)
        :duration (= ?duration 4)
        :condition (and (at start (robot_at ?r ?l1)) (at start (carrier_at ?ca ?l1)))
        :effect (and (at end (robot_at ?r ?l2)) (at end (carrier_at ?ca ?l2))
                    (at start (not (robot_at ?r ?l1))) (at start (not (carrier_at ?ca ?l1))))
    )
    
    (:durative-action move
        :parameters (?r - robot ?l1 ?l2 - location)
        :duration (= ?duration 3)
        :condition (and (at start (robot_at ?r ?l1)))
        :effect (and (at end (robot_at ?r ?l2)) (at start (not (robot_at ?r ?l1))))
    )

    (:durative-action deliver
        :parameters (?r - robot ?ca - carrier ?c - crate ?p - person ?l - location ?co - content)
        :duration (= ?duration 1)
        :condition (and (over all (robot_at ?r ?l)) (over all (carrier_at ?ca ?l)) (over all (person_at ?p ?l))
                        (at start (not (busy ?r))) (at start (load ?ca ?c)) (over all (contain ?c ?co)) 
                        (at start (need ?p ?co)))
        :effect (and (at start (busy ?r)) (at end (not (busy ?r))) (at start (not (load ?ca ?c))) 
                (at start (not (need ?p ?co))) (at end (have ?p ?co)) (at end (not (available ?c))) 
                (at end (crate_at ?c ?l)) (at end (increase (capacity ?ca) 1)))
    )

    ; assume each robot can perform just one action per time -> many robot can perform the same action in parallel

)