(define (problem problem1) (:domain assignment1)
    (:objects 
        robot1 - robot
        p1 p2 p3 p4 - person
        c1 c2 c3 c4 c5 - crate
        depot l1 l2 l3 - location
        medicine food beverage - content
    )

    (:init
        (at-robot robot1 depot) 
        (at-person p1 l1) (at-person p2 l2) (at-person p3 l3) (at-person p4 l3)
        (at-crate c1 depot) (at-crate c2 depot) (at-crate c3 depot) (at-crate c4 depot) (at-crate c5 depot) ; (at-crate c6 depot) 
        (contain c1 medicine) (contain c2 food) (contain c3 beverage) (contain c4 medicine) (contain c5 food)
        (available c1) (available c2) (available c3) (available c4) (available c5)
        (need p1 food) (need p1 beverage)
        (need p3 medicine)
        (need p4 food)
        (have p1 medicine) (have p2 food) (have p3 beverage)
        (empty robot1)
    )

    (:goal (and
        (have p1 food) (have p1 beverage)
        (have p3 medicine)
        (have p4 food)
    ))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
