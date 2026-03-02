package com.abgt.mumblebackend.repository;

import com.abgt.mumblebackend.model.MumbleModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MumbleRepository extends JpaRepository<MumbleModel,Long>
{

}
