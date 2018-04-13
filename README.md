# BazyDanychPtak

Projekt na zal baz danych.


# CI

http://80.211.241.169:8080/job/BazyZdanychCI/


# Info

- Ściągnięcie repo `git clone 'https://github.com/Fotoblysk/BazyDanychPtak'`
- Aktualizacja repo na konkretnym branchu repo `git pull`
- Jak coś pytać.


# Workflow

1. Zrób nowego brancha z nazwą opisującą ficzer `git checkout master ; git checkout -b super_nowy_ficzer`.
2. Dokonaj zmian i dodaj do lokalnego repo `git add . ; git commit -m 'Super nowy ficzer- dodanie latana w kosmos.'`
3. Zwiń komity do 1 z tekstem opisującym ficzer `git rebase -it <commit od którego zacząłeś>` podgląd commitów git log
Dodawanie zmian do istniejącego do commita `git commit --ammend`
4. Pull master `git checkout master ; git pull ; git checkout <nazwa brancha> ; git rebase master`
5. Popraw konflikty.
6. Push.
6.5 Czekaj na review.
7. Jeżeli testy przeszły merge (i ew. review też) merge z stronki do mastera.
