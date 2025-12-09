package com.hospital.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "service")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Service {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String nom;

    @Column(name = "budget_mensuel")
    private Double budgetMensuel;

    @Column(name = "budget_annuel")
    private Double budgetAnnuel;

    @Column(name = "cout_actuel")
    private Double coutActuel = 0.0;
}
