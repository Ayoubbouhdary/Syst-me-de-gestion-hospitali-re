package com.hospital.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "soin")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Soin {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "patient_id")
    private Long patientId;

    @Column(name = "service_id")
    private Long serviceId;

    @Column(name = "type_soin", length = 100)
    private String typeSoin;

    @Column(nullable = false)
    private Double cout;

    @Column(name = "date_soin")
    private LocalDateTime dateSoin;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}
