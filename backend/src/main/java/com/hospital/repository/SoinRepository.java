package com.hospital.repository;

import com.hospital.model.Soin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SoinRepository extends JpaRepository<Soin, Long> {
    List<Soin> findByPatientId(Long patientId);

    List<Soin> findByServiceId(Long serviceId);
}
