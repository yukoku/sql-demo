SELECT P0.sin,
       P0.pen_year AS start_year,
       P2.pen_year AS end_year,
       SUM(P1.earnings) AS sumofearning
FROM Pensions AS P0, Pensions AS P1, Pensions AS P2
WHERE P0.month_cnt > 0
AND P1.month_cnt > 0
AND P2.month_cnt > 0
AND P0.sin = P1.sin
AND P0.sin = P2.sin
AND P0.pen_year BETWEEN P2.pen_year - 59 AND (P2.pen_year - 4)
AND P1.pen_year BETWEEN P0.pen_year AND P2.pen_year
GROUP BY P0.sin, P0.pen_year, P2.pen_year
HAVING SUM(p1.month_cnt) >= 60
AND (P2.pen_year - P0.pen_year) = (COUNT(*) - 1)
;
