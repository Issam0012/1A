Configuration projet

- Il faut utiliser JBoss EAP 7

- Il faut ajouter dans son buildPath
EAP-7.0.0/modules/system/layers/base/com/fasterxml/jackson/core/jackson-annotations/main/jackson-annotations-2.5.4.redhat-1.jar
EAP-7.0.0/modules/system/layers/base/com/fasterxml/jackson/core/jackson-databind/main/jackson-databind-2.5.4.redhat-1.jar
EAP-7.0.0/modules/system/layers/base/com/fasterxml/jackson/core/jackson-core/main/jackson-core-2.5.4.redhat-1.jar
EAP-7.0.0/modules/system/layers/base/javax/ws/rs/api/main/jboss-jaxrs-api_2.0_spec-1.0.0.Final-redhat-1.jar
EAP-7.0.0/modules/system/layers/base/com/fasterxml/jackson/core/jackson-annotations/main/jackson-annotations-2.5.4.redhat-1.jar
EAP-7.0.0/modules/system/layers/base/javax/ws/rs/api/main/jboss-jaxrs-api_2.0_spec-1.0.0.Final-redhat-1.jar
EAP-7.0.0/modules/system/layers/base/javax/ejb/api/main/jboss-ejb-api_3.2_spec-1.0.0.Final-redhat-1.jar
EAP-7.0.0/modules/system/layers/base/javax/persitence/api/main/hibernate-jpa-2. 1-api.1.0.0.Final-redhat.jar
EAP-7.0.0/modules/system/layers/base/javax/transaction/api/main/jboss-transaction-api_1.2_spec-1.0.0.Final-redhat-1.jar
JSON jar from http://www.java2s.com/Code/Jar/j/Downloadjavajsonjar.htm


- importer dans le projet
	- les sources java dans un paquet pack1
	- persistence.xml dans le dossier src/META-INF
	- les pages html dans le dossier WebContent
	_ le dossier css dans le dossier WebContent
	- le dossier images dans WebContent
	- web.xml dans le dossier WebContent/WEB-INF

- mettre les fichiers.sql dans EAP-7.0.0/bin

-pour le fichier persitence.xml.
	- Si on ne veut pas une base de donnée persistente, il faut décommenter  <jta-data-source>java:jboss/datasources/ExampleDS</jta-data-source> et commenter <jta-data-source>java:/H2moviemetricDS</jta-data-source>
	- Si on veut une base donnée persitence il faut créer une nouvelle base de donnée.
	Pour ce faire, il faut:
		- lancer la commande ./add-user.sh dans EAP-7.0.0/bin
		- créer un management user avec un pseudo et un mdp.
		- chercher la page localhost:9990 et lancer le serveur (si votre base n'est pas encore
		créé il faut  décommenter  <jta-data-source>java:jboss/datasources/ExampleDS</jta-data-
		source> et commenter <jta-data-source>java:/H2moviemetricDS</jta-data-source> dans
		persitence.xml pour éviter des problèmes.
		- taper son pseudo et son mdp défini précédemment et aller dans Configuration/Subsystems/
		Datasources/Non-XA
		-ajouter une nouvelle H2datasource qui devra être défini avec comme nom H2moviemetricDS,
		comme JDNI : java:/H2moviemetricDS et comme connection_url jdbc:h2:file:pathToFile/
		moviemetricDB;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE

		le PathToFile représente le chemin pour atteindre le dossier qui contiendra votre base
		de données dans un fichier.

		Il ne faut pas oublier de recommenter <jta-data-source>java:jboss/datasources/ExampleDS</
		jta-data-source> et de décommenter   <jta-data-source>java:/H2moviemetricDS</jta-data-source>

- déployez le dans JBoss comme précédemment
