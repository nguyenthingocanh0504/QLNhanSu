-- MySQL Workbench Synchronization
-- Generated: 2023-03-16 21:31
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Nguyen Van

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `quanlysanpham`.`chucvu_has_nhanvien` 
DROP FOREIGN KEY `fk_chucvu_has_nhanvien_chucvu1`,
DROP FOREIGN KEY `fk_chucvu_has_nhanvien_nhanvien1`;

ALTER TABLE `quanlysanpham`.`hopdonglaodong` 
ADD INDEX `fk_hopdonglaodong_nhanvien1_idx` (`MaNV` ASC) VISIBLE;
;

ALTER TABLE `quanlysanpham`.`nhanvien` 
ADD COLUMN `MaPB` INT(11) NOT NULL AFTER `QueQuan`,
ADD COLUMN `MaTrinhDoHocVan` INT(11) NOT NULL AFTER `MaPB`,
ADD COLUMN `BacLuong` DOUBLE NOT NULL AFTER `MaTrinhDoHocVan`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`MaNV`, `MaTrinhDoHocVan`, `BacLuong`),
ADD INDEX `fk_nhanvien_phongban_idx` (`MaPB` ASC) VISIBLE,
ADD INDEX `fk_nhanvien_trinhdohocvan1_idx` (`MaTrinhDoHocVan` ASC) VISIBLE,
ADD INDEX `fk_nhanvien_luong1_idx` (`BacLuong` ASC) VISIBLE;
;

ALTER TABLE `quanlysanpham`.`hopdonglaodong` 
ADD CONSTRAINT `fk_hopdonglaodong_nhanvien1`
  FOREIGN KEY (`MaNV`)
  REFERENCES `quanlysanpham`.`nhanvien` (`MaNV`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `quanlysanpham`.`nhanvien` 
ADD CONSTRAINT `fk_nhanvien_phongban`
  FOREIGN KEY (`MaPB`)
  REFERENCES `quanlysanpham`.`phongban` (`MaPB`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_nhanvien_trinhdohocvan1`
  FOREIGN KEY (`MaTrinhDoHocVan`)
  REFERENCES `quanlysanpham`.`trinhdohocvan` (`MaTrinhDoHocVan`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_nhanvien_luong1`
  FOREIGN KEY (`BacLuong`)
  REFERENCES `quanlysanpham`.`luong` (`BacLuong`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `quanlysanpham`.`chucvu_has_nhanvien` 
ADD CONSTRAINT `fk_chucvu_has_nhanvien_chucvu1`
  FOREIGN KEY (`chucvu_MaCV`)
  REFERENCES `quanlysanpham`.`chucvu` (`MaCV`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_chucvu_has_nhanvien_nhanvien1`
  FOREIGN KEY (`nhanvien_MaNV`)
  REFERENCES `quanlysanpham`.`nhanvien` (`MaNV`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
