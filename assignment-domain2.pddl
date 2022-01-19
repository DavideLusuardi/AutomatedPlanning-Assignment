;Header and description

(define (domain assignment2)

    (:requirements :strips :typing :fluents)

    (:types
        robot
        person
        crate
        location
        content
        carrier
    )

    (:predicates
        (robot_at ?r - robot ?l - location)
        (person_at ?p - person ?l - location)
        (crate_at ?c - crate ?l - location)
        (carrier_at ?ca - carrier ?l - location)
        (contain ?c - crate ?co - content) ; assume contains only one content
        (available ?c - crate)
        (need ?p - person ?co - content) ; no need content already had
        (have ?p - person ?co - content)
        (load ?ca - carrier ?c - crate)
    )


    (:functions
        ; (full-capacity) - number
        (capacity ?ca - carrier) - number
        (cost) - number
    )

    (:action pick-up
        :parameters (?r - robot ?ca - carrier ?c - crate ?l - location)
        :precondition (and (robot_at ?r ?l) (carrier_at ?ca ?l) (crate_at ?c ?l) 
                            (available ?c) (> (capacity ?ca) 0))
        :effect (and (load ?ca ?c) (decrease (capacity ?ca) 1) (not (crate_at ?c ?l)) (increase (cost) 1))
    )
    
    (:action move-carrier
        :parameters (?r - robot ?ca - carrier ?l1 ?l2 - location)
        :precondition (and (robot_at ?r ?l1) (carrier_at ?ca ?l1))
        :effect (and (robot_at ?r ?l2) (carrier_at ?ca ?l2) 
                    (not (robot_at ?r ?l1)) (not (carrier_at ?ca ?l1)) (increase (cost) 1))
    )
    
    (:action move
        :parameters (?r - robot ?l1 ?l2 - location)
        :precondition (and (robot_at ?r ?l1))
        :effect (and (robot_at ?r ?l2) (not (robot_at ?r ?l1)) (increase (cost) 1))
    )

    (:action deliver
        :parameters (?r - robot ?ca - carrier ?c - crate ?p - person ?l - location ?co - content)
        :precondition (and (robot_at ?r ?l) (carrier_at ?ca ?l) (person_at ?p ?l) 
                        (load ?ca ?c) (contain ?c ?co) (need ?p ?co))
        :effect (and (not (need ?p ?co)) (have ?p ?co) (crate_at ?c ?l) 
                    (not (load ?ca ?c)) (increase (capacity ?ca) 1) (not (available ?c)) (increase (cost) 1))
    )

)