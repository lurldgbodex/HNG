package tech.sgcor.hng.organisation.entity;

import jakarta.persistence.*;
import lombok.*;
import tech.sgcor.hng.user.entity.User;

import java.util.*;

@Getter
@Setter
@Builder
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "organisations")
public class Organisation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long orgId;

    @Column(nullable = false)
    private String name;

    private String description;

    @ManyToMany(mappedBy = "organisations")
    private Set<User> users;

}
