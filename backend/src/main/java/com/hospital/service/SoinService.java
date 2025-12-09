package com.hospital.service;

import com.hospital.model.Soin;
import com.hospital.repository.SoinRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class SoinService {

    private final SoinRepository soinRepository;

    public List<Soin> getAllSoins() {
        return soinRepository.findAll();
    }

    public Optional<Soin> getSoinById(Long id) {
        return soinRepository.findById(id);
    }

    public Soin createSoin(Soin soin) {
        return soinRepository.save(soin);
    }

    public List<Soin> getSoinsByPatientId(Long patientId) {
        return soinRepository.findByPatientId(patientId);
    }

    public List<Soin> getSoinsByServiceId(Long serviceId) {
        return soinRepository.findByServiceId(serviceId);
    }
}
