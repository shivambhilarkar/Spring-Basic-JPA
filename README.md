#  Spring-Basic-JPA

##  Basic Annotations 

### @Entity
This annotation indicates that the class is mapped to a database table. By default, the ORM framework understands that the class name is as same as the table name. The @Entity annotation must be placed before the class definition:
```
@Entity 
public class User {
…
}
```
 
### @Table
This annotation is used if the class name is different than the database table name, and it is must placed before the class definition. Since the class name is User and the table name is Users, we have to use this annotation:
```
@Entity
@Table(name = "USERS")
public class User {
```
 
### @Column
This annotation is used to map an instance field of the class to a column in the database table, and it is must placed before the getter method of the field. By default, Hibernate can implicitly infer the mapping based on field name and field type of the class. But if the field name and the corresponding column name are different, we have to use this annotation explicitly. This
In our model class, the field name id is different than the column user_id, so we have to use the @Column annotation as follows:
```
@Column(name = "USER_ID")
public Integer getId() {
    return id;
}
```
The other fields (fullname, email and password) have identical names as the corresponding columns in the table so we don’t have to annotate those fields.
 
### @Id
This annotation specifies that a field is mapped to a primary key column in the table. Since the column user_id is a primary key, we have to use this annotation as follows:
```
@Column(name = "USER_ID")
@Id
public Integer getId() {
    return id;
}
```
 
### @GeneratedValue
If the values of the primary column are auto-increment, we need to use this annotation to tell Hibernate knows, along with one of the following strategy types: AUTO, IDENTITY, SEQUENCE, and TABLE. In our case, we use the strategy IDENTITY which specifies that the generated values are unique at table level, whereas the strategy AUTO implies that the generated values are unique at database level.
Therefore, the getter method of the field id is annotated as follows:
```
@Column(name = "USER_ID")
@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
public Integer getId() {
    return id;
}
``` 

Finally, we have the model class User is annotated as follows:
```
package net.codejava.hibernate; 
import javax.persistence.*;

@Entity
@Table(name = "USERS")
public class User {
    private Integer id;
    private String fullname;
    private String email;
    private String password;
 
    @Column(name = "USER_ID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Integer getId() {
        return id;
    }
 
    // other setters and getters are not shown for brevity
}
```
