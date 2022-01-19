(define (problem problem1) (:domain assignment1)
    (:objects 
        robot1 - robot
        p1 p2 p3 p4 - person
        c1 c2 c3 c4 c5 - crate
        depot l1 l2 l3 - location
        medicine food beverage - content
    )

    (:init
        (robot_at robot1 depot) 
        (person_at p1 l1) (person_at p2 l2) (person_at p3 l3) (person_at p4 l3)
        (crate_at c1 depot) (crate_at c2 depot) (crate_at c3 depot) (crate_at c4 depot) (crate_at c5 depot) ; (crate_at c6 depot) 
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
