---
author: leovct
title: 🔭 En quoi consiste mon travail d'ingénieur informatique ?
description: Une explication de mon travail au quotidien, du plus simple au plus technique
date: 2026-11-02
build:
  list: never
altUrl: /posts/what-i-do/
altLang: en
altLabel: 🇬🇧 English version
tags:
  - blockchain
  - reliability
  - infra
---

Quand on me demande ce que je fais dans la vie, la conversation ressemble souvent à ceci :

{{< chat right Someone >}}Tu fais quoi dans la vie ?{{< /chat >}}
{{< chat left Me >}}Je suis ingénieur en informatique{{< /chat >}}
{{< chat right Someone >}}Ah cool !{{< /chat >}}
{{< chat right Someone >}}Tu codes des applications ?{{< /chat >}}
{{< chat left Me >}}Pas vraiment{{< /chat >}}
{{< chat left Me >}}Je fais de l'infra{{< /chat >}}
{{< chat right Someone >}}Hmmm ok...{{< /chat >}}
{{< chat right Someone >}}Et tu travailles pour qui ?{{< /chat >}}
{{< chat left Me >}}Polygon{{< /chat >}}
{{< chat left Me >}}On construit des blockchains et des solutions de paiement{{< /chat >}}
{{< chat right Someone >}}Attends{{< /chat >}}
{{< chat right Someone >}}C'est quoi une blockchain ?!{{< /chat >}}
{{< chat left Me >}}Alors...{{< /chat >}}
{{< chat left Me >}}&lt;explication compliquée que personne ne comprend&gt;{{< /chat >}}

Pas facile de répondre : la blockchain et l'infra sont des sujets techniques compliqués à expliquer... On imagine souvent les applications et les sites web, mais pas la partie immergée de l'iceberg qui fait tourner Internet.

Alors, pour couper court, je finis souvent par répondre :

{{< chat left Me >}}En gros...{{< /chat >}}
{{< chat left Me >}}J'écris du code quoi...{{< /chat >}}
{{< chat left Me >}}Je parle à des ordinateurs toute la journée{{< /chat >}}

Et quand la personne a déjà entendu parler de blockchain, la conversation s'oriente rapidement vers la spéculation :

{{< chat right Someone >}}Ah, tu travailles dans la blockchain ?{{< /chat >}}
{{< chat right Someone >}}J'ai investi dans le Bitcoin en 2021{{< /chat >}}
{{< chat right Someone >}}J'ai acheté un meme coin{{< /chat >}}
{{< chat right Someone >}}J'ai aussi pris quelques NFT...{{< /chat >}}
{{< chat right Someone >}}Tu penses que le Bitcoin va repasser au-dessus des 100 000 $ avant la fin du bull run ?{{< /chat >}}
{{< chat left Me >}}Aucune idée{{< /chat >}}
{{< chat left Me >}}Je ne suis pas conseiller financier{{< /chat >}}
{{< chat left Me >}}Je travaille sur les réseaux, pas sur les cours{{< /chat >}}
{{< chat right Someone >}}Et c'est quoi la crypto de ta boîte ?{{< /chat >}}
{{< chat left Me >}}POL{{< /chat >}}
{{< chat left Me >}}C'est le token du réseau{{< /chat >}}
{{< chat left Me >}}Avant, il s'appelait MATIC{{< /chat >}}
{{< chat right Someone >}}Et ça vaut combien ?{{< /chat >}}
{{< chat left Me >}}Honnêtement, je ne suis pas la bonne personne à qui demander{{< /chat >}}
{{< chat left Me >}}Je contribue simplement à ce que les réseaux tournent{{< /chat >}}

Voici donc ma tentative de réponse, en deux niveaux, du plus simple au plus technique, suivis d'un regard sur la façon dont l'IA a changé mon quotidien.

## La version courte

Les blockchains sont des réseaux qui font circuler de l'argent et des données sans qu'une seule entreprise ne tienne les registres. Quand l'une d'elles dysfonctionne, les utilisateurs peuvent perdre de l'argent, ou perdre confiance. Je contribue à ce que les réseaux et les applications de Polygon fonctionnent, et continuent de fonctionner, en construisant les outils qui permettent aux ingénieurs de les tester avant leur mise en production et de détecter les problèmes le plus tôt possible une fois qu'ils sont en ligne.

Prenez par exemple le domaine de l'aviation : certains conçoivent les avions, d'autres construisent les simulateurs de vol et les instruments qui alertent l'équipage avant que quelque chose ne tourne mal. Je travaille sur les simulateurs et les systèmes d'alerte. Personne ne veut voir un avion s'écraser, et c'est pareil pour nous : personne ne veut que des utilisateurs perdent leur argent, qu'une faille de sécurité soit exploitée ou qu'une chaîne s'arrête et gèle les actifs qui y circulent.

### Qu'est-ce qu'une blockchain, et à quoi ça sert ?

Aujourd'hui, pour envoyer de l'argent ou payer quelque chose, on passe par un intermédiaire. Une banque a ses propres procédures et peut bloquer un virement. Les fintechs comme Revolut ou PayPal sont plus rapides, mais restent des intermédiaires et peuvent aussi geler vos fonds. Bon... Revolut est devenue une banque dans certains pays, mais vous voyez l'idée.

Une blockchain, au contraire, fonctionne grâce à de nombreux ordinateurs indépendants : en principe, aucune entreprise n'a à détenir vos fonds ni à valider vos paiements. Avec un portefeuille que vous contrôlez vous-même, l'argent est à vous. C'est surtout utile là où les banques ne suffisent pas : envoyer de l'argent à l'étranger vite et à bas coût, ou toucher les personnes qui n'ont pas de compte en banque.

Toutes les blockchains ne se ressemblent pas : elles sont plus ou moins décentralisées, plus ou moins rapides, offrent des niveaux de sécurité différents, et chacune répond à un cas d'usage. Bitcoin privilégie la sécurité et la décentralisation, comme réserve de valeur. Ethereum est une plateforme généraliste pour les applications et les contrats intelligents (smart contracts). Solana et Polygon PoS visent la vitesse et les frais faibles, pour les paiements et les applications grand public.

## Pour les profils techniques

On peut voir une blockchain comme une base de données difficile à falsifier, partagée par de nombreux ordinateurs, sans opérateur central. Ces ordinateurs n'ont pas besoin de se faire confiance : ils suivent les mêmes règles (le consensus) pour s'accorder sur l'ordre des transactions, et les données sont stockées dans des blocs chaînés par des empreintes cryptographiques, ce qui rend toute réécriture de l'historique détectable, et le consensus la rend extrêmement difficile.

En plus, les contrats intelligents sont des programmes qui s'exécutent sur cette base de données partagée. On s'en sert, par exemple, pour prêter et emprunter de l'argent sans banque (lending), échanger une monnaie contre une autre (swaps), ou émettre des stablecoins (des jetons indexés sur des monnaies comme le dollar ou l'euro). Ils peuvent aussi représenter des objets uniques sous forme de jetons (NFT), tokeniser des actifs réels ou faire passer des fonds d'un réseau à un autre (bridging).

Polygon développe plusieurs réseaux et produits blockchain, chacun composé de nombreux éléments (nœuds, ponts, contrats intelligents, API, portefeuilles) qui doivent interopérer. Deux questions guident mon travail :

- Puis-je tester un changement face au reste de la stack, rapidement et de façon reproductible ?
- Saurions-nous, avant que nos utilisateurs ne nous le disent, que quelque chose est dégradé ?

Pour répondre à ces deux questions, mon travail s'organise autour de quatre domaines.

### Devnets

Démarrer un réseau blockchain complet était long, pénible à mettre en place et difficile à maintenir. Je maintiens des paquets [Kurtosis](https://github.com/kurtosis-tech/kurtosis) ([kurtosis-cdk](https://github.com/0xPolygon/kurtosis-cdk/), [kurtosis-pos](https://github.com/0xPolygon/kurtosis-pos), [optimism-package](https://github.com/agglayer/optimism-package)) qui le font en quelques minutes, sur un ordinateur portable ou en CI. En novembre 2026, kurtosis-cdk compte à lui seul 80 étoiles, 131 forks et 48 contributeurs sur GitHub.

### Monitoring

Une fois un service en ligne, l'objectif est de détecter les problèmes au plus tôt, surtout avant nos utilisateurs. Pour cela, nous utilisons nos services comme le ferait un utilisateur : des vérifications indépendantes tournent à intervalle régulier depuis plusieurs régions du monde, sur des dizaines de types de contrôles. Par exemple, envoyer des transactions à un réseau et mesurer le temps qu'elles mettent à être incluses, ou le temps que des actifs mettent à passer d'un réseau à un autre. En complément, nous définissons des indicateurs et des objectifs de niveau de service (ce que « fonctionne bien » veut dire, en chiffres) pour les services les plus importants.

### Tests

Des tests automatisés qui s'exécutent sur ces devnets, mais pas seulement : ils n'ont besoin que d'un point d'accès RPC, donc ils peuvent aussi viser d'autres environnements, y compris de vrais réseaux. Ils envoient des transactions, font passer des actifs d'un réseau à l'autre et vérifient que tout se comporte comme prévu, jusqu'à des scénarios plus complexes comme les hard forks (mises à jour du réseau). Ils tournent en CI, en local, et peuvent aussi être lancés par des agents IA, par exemple lors de campagnes de tests nocturnes. Ensemble, les suites AggLayer et PoS comptent des centaines de cas de test.

### Outils

Une boîte à outils en ligne de commande pour les développeurs et les opérateurs de blockchains, dans l'esprit de [foundry](https://github.com/foundry-rs/foundry). [polygon-cli](https://github.com/0xPolygon/polygon-cli/) regroupe les opérations courantes dans un seul outil cohérent : faire des tests de charge sur un réseau, parcourir les blocs avec un explorateur de blockchain dans le terminal, créer et alimenter des portefeuilles, et plus encore.

## Une journée type

Avant l'IA générative, mon travail suivait une boucle simple : backlog, tickets, conception, implémentation, tests, livraison. Quand un bug ou un incident arrivait, je passais de quelques heures à plusieurs jours à chercher la cause, parfois une semaine entière, puis je livrais le correctif. Les preuves de concept (de petits prototypes pour vérifier qu'une idée fonctionne) pouvaient demander autant de temps, parfois des semaines.

Avec les IA génératives très performantes, le travail est différent. J'écris des spécifications, je les fais relire par des agents IA, je demande à d'autres agents de les implémenter, à d'autres de les tester, et je livre après avoir vérifié que tout tourne. Ce n'est pas moins de travail, c'est un travail différent : moins de temps à écrire du code, plus de temps à décider ce qu'il faut construire, à définir ce que « terminé » veut dire et à vérifier le résultat.

Résultat : un changement d'échelle. Je peux traiter bien plus de travail qu'avant, parce que plusieurs agents travaillent en parallèle pendant que j'écris des spécifications et que je relis les résultats, au lieu de faire chaque étape l'une après l'autre. Et je peux m'attaquer à des problèmes plus difficiles, y compris certains que je ne maîtrisais pas : un agent peut écrire du code dans un langage ou un outil que je connais moins bien, explorer plusieurs approches en quelques minutes, ou expliquer une base de code inconnue.

L'autre moitié du métier consiste à construire le cadre de travail des agents (les instructions, les outils et les vérifications avec lesquels ils travaillent) et à raccourcir le temps entre une erreur et sa détection.

En clair : avant, j'étais un peu comme un forgeron, à façonner chaque pièce à la main, à la polir pour la rendre la plus parfaite possible. Aujourd'hui, je suis plus proche d'un chef d'orchestre : je ne joue pas de tous les instruments moi-même, je briefe une équipe d'assistants IA très compétents, je vérifie ce qu'ils livrent, et je continue d'améliorer les consignes et les listes de contrôle que je leur donne, pour qu'ils réussissent plus souvent, pour moins cher, sans que j'aie à les surveiller en permanence.

Pour en savoir plus sur mes travaux, voir la page [projets](/projects) (en anglais).

_Cet article a été écrit avec l'aide d'une IA (Claude Sonnet 5.5), à partir de mes idées et sous ma relecture. Ce qui illustre bien, justement, la façon de travailler qu'il décrit._
