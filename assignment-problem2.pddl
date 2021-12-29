(define (problem problem2) (:domain assignment2)
    (:objects 
        robot1 - robot
        p1 p2 p3 p4 p5 p6 - person
        c1 c2 c3 c4 c5 c6 - crate
        depot l1 l2 l3 - location
        medicine food beverage - content
        carrier1 - carrier
    )

    (:init
        (at-robot robot1 depot) 
        (at-carrier carrier1 depot)
        (at-person p1 l1) (at-person p2 l1) (at-person p3 l1) (at-person p4 l2) (at-person p5 l2) (at-person p6 l3)
        (at-crate c1 depot) (at-crate c2 depot) (at-crate c3 depot) (at-crate c4 depot) (at-crate c5 depot) (at-crate c6 depot) 
        (contain c1 medicine) (contain c2 food) (contain c3 beverage) (contain c4 medicine) (contain c5 food) (contain c6 beverage)
        (available c1) (available c2) (available c3) (available c4) (available c5) (available c6)
        (need p1 food) (need p1 beverage)
        (need p3 medicine)
        (need p4 food)
        (need p5 medicine)
        (need p6 beverage)
        (have p1 medicine) (have p2 food) (have p3 beverage)
        (= (capacity carrier1) 4)
        (= (cost) 0)
    )

    (:goal (and
        (have p1 food) (have p1 beverage)
        (have p3 medicine)
        (have p4 food)
        (have p5 medicine)
        (have p6 beverage)
        ; (< (cost) 17)
    ))

    ;un-comment the following line if metric is needed
    (:metric minimize (cost))
    ; min cost 16 
)
