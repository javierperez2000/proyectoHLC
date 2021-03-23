sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf
slq_usuario="root"
sql_password="root"
sql_args="-u $slq_usuario -p$sql_password -s -e"
mysql $sql_args "CREATE DATABASE correo;"
mysql $sql_args "GRANT SELECT ON correo.* TO 'usuariocorreo'@'172.128.20.%' IDENTIFIED BY 'usuariocorreo';"
mysql $sql_args "FLUSH PRIVILEGES;"
mysql $sql_args "USE correo;"
mysql $sql_args "CREATE TABLE virtual_domains (id int(11) NOT NULL auto_increment,name varchar(50) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=utf8;" correo
mysql $sql_args "CREATE TABLE virtual_users (id int(11) NOT NULL auto_increment,domain_id int(11) NOT NULL,password varchar(32) NOT NULL,email varchar(100) NOT NULL,PRIMARY KEY (id),UNIQUE KEY email (email),FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE) ENGINE=InnoDB DEFAULT CHARSET=utf8;" correo
mysql $sql_args "CREATE TABLE virtual_aliases (id int(11) NOT NULL auto_increment,domain_id int(11) NOT NULL,source varchar(100) NOT NULL,destination varchar(100) NOT NULL, PRIMARY KEY (id),FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE) ENGINE=InnoDB DEFAULT CHARSET=utf8;" correo
mysql $sql_args "INSERT INTO correo.virtual_domains (id, name) VALUES (1, 'jperez.tk');"
mysql $sql_args "INSERT INTO correo.virtual_users (id, domain_id,password, email) VALUES (1, 1, MD5('usuario'), 'javi@jperez.tk');"
mysql $sql_args "INSERT INTO correo.virtual_users (id, domain_id,password, email) VALUES (2, 1, MD5('usuario'), 'jc@jperez.tk');"
mysql $sql_args "INSERT INTO correo.virtual_users (id, domain_id,password, email) VALUES (3, 1, MD5('usuario'), 'morgado@jperez.tk');"
mysql $sql_args "CREATE DATABASE roundcube;"
mysql $sql_args "GRANT ALL PRIVILEGES ON roundcube.* TO 'roundcube'@'172.128.20.%' IDENTIFIED BY 'roundcube';"
mysql $sql_args "FLUSH PRIVILEGES;"
mysql -u $slq_usuario -p$sql_password roundcube < /root/mysql.initial.sql