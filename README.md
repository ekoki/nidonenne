## サービス概要

2度寝をしてしまう人のために、2度寝を防止するサービス。

## メインのターゲットユーザー

朝に勉強を頑張りたいと考えているが、2度寝をしてしまい、朝の勉強時間が短くなってしまう人。

## ユーザーが抱える課題

忙しい中で勉強をしている人は、日々の生活の中で勉強時間を確保する必要がある。  
しかし、社会人や学生等、勉強時間は限られており、その中で勉強時間を確保するためには、早起きして朝の時間を確保することは大切であるが、朝起きるのは大変。

## 解決方法

朝起きた直後に頭を働かせることにより、少しでも眠気を減らす。また、継続的に二度寝をしていないという状況を可視化することにより、二度寝することに対する心理的抵抗を増やす。  
このアプリでは朝に英単語の問題がLINEに通知され、二度寝の状況がカレンダーに反映される。  
具体的には、起床時に英単語の問題がLINEに通知される。この英単語については、前日の就寝時にあらかじめ登録しておく。LINE通知後10分以内に問題の回答ができるとカレンダーに反映される。

## 主な実装機能

- マイページにアクセスすることができる
- LINEとアプリの連携をすることができる
- LINEへの通知設定をすることができる  
- 英単語の問題設定をすることができる
- 英単語を自動で作成することができる(自動で作成する場合には、あらかじめデータベースで登録されている問題が設定される)
- 英単語の問題を解答することができる

## なぜこのサービスを作りたいのか？

私自身、アラームをかけても止めてしまい二度寝をすることがある。二度寝をすることにより朝の勉強時間が少なくなり、一日あたりでは差がなくても長い目で見ればその差はとても大きなものになる。そのため、二度寝を防止するためのサービスを作りたいと思った。  
二度寝を防止するために、朝起きてすぐに問題を解くことによって、頭を働かせる。さらに、カレンダーで二度寝の状況を把握できることによって、継続するモチベーションにつながるようにした。また、自分自身で勉強したことを問題として設定し、朝に復習として解くことによって記憶の定着も進み、勉強への手助けにもなると考えた。  
このサービスで二度寝防止だけでなく、勉強への一助になればいいなと思った。

## 技術選定

**バックエンド**
- Ruby on Rails

**フロントエンド**
- jQuery
- TailwindCSS
- daisyUI

**外部API**
- LINE Messaging API

**インフラ等**
- Sidekiq
- Redis
- Heroku


## 画面遷移図

https://www.figma.com/file/Jfx0llfG7TVhXcevYjxUjV/PF%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0%3A1&t=oAIbSPkD4yl9vMLg-1

## ER図

![image](https://github.com/ekoki/nidonenne/assets/78673091/2d864108-476d-46f7-bfd9-99249dc370fe)
