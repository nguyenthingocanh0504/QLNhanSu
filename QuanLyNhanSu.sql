-- MySQL Script generated by MySQL Workbench
-- Thu Mar 16 21:04:55 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema salesmanagementdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema salesmanagementdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `salesmanagementdb` DEFAULT CHARACTER SET utf8mb3 ;
-- -----------------------------------------------------
-- Schema quanlysanpham
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema quanlysanpham
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `quanlysanpham` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `salesmanagementdb` ;

-- -----------------------------------------------------
-- Table `salesmanagementdb`.`offices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesmanagementdb`.`offices` (
  `officeCode` VARCHAR(10) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  `addressLine1` VARCHAR(50) NOT NULL,
  `addressLine2` VARCHAR(50) NULL DEFAULT NULL,
  `state` VARCHAR(50) NULL DEFAULT NULL,
  `country` VARCHAR(50) NOT NULL,
  `postalCode` VARCHAR(15) NOT NULL,
  `territory` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`officeCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `salesmanagementdb`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesmanagementdb`.`employees` (
  `employeeNumber` INT NOT NULL,
  `lastName` VARCHAR(50) NOT NULL,
  `firstName` VARCHAR(50) NOT NULL,
  `extension` VARCHAR(10) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `officeCode` VARCHAR(10) NOT NULL,
  `reportsTo` INT NULL DEFAULT NULL,
  `jobTitle` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`),
  INDEX `employees_ibfk_1` (`reportsTo` ASC) VISIBLE,
  INDEX `employees_ibfk_2` (`officeCode` ASC) VISIBLE,
  CONSTRAINT `employees_ibfk_1`
    FOREIGN KEY (`reportsTo`)
    REFERENCES `salesmanagementdb`.`employees` (`employeeNumber`),
  CONSTRAINT `employees_ibfk_2`
    FOREIGN KEY (`officeCode`)
    REFERENCES `salesmanagementdb`.`offices` (`officeCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `salesmanagementdb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesmanagementdb`.`customers` (
  `customerNumber` INT NOT NULL,
  `customerName` VARCHAR(50) NOT NULL,
  `contactLastName` VARCHAR(50) NOT NULL,
  `contactFirstName` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  `addressLine1` VARCHAR(50) NOT NULL,
  `addressLine2` VARCHAR(50) NULL DEFAULT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` VARCHAR(50) NULL DEFAULT NULL,
  `postalCode` VARCHAR(15) NULL DEFAULT NULL,
  `country` VARCHAR(50) NOT NULL,
  `salesRepEmployeeNumber` INT NULL DEFAULT NULL,
  `creditLimit` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`customerNumber`),
  INDEX `salesRepEmployeeNumber` (`salesRepEmployeeNumber` ASC) VISIBLE,
  CONSTRAINT `customers_ibfk_1`
    FOREIGN KEY (`salesRepEmployeeNumber`)
    REFERENCES `salesmanagementdb`.`employees` (`employeeNumber`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `salesmanagementdb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesmanagementdb`.`orders` (
  `orderNumber` INT NOT NULL,
  `orderDate` DATE NOT NULL,
  `requiredDate` DATE NOT NULL,
  `shippedDate` DATE NULL DEFAULT NULL,
  `status` VARCHAR(15) NOT NULL,
  `comments` TEXT NULL DEFAULT NULL,
  `customerNumber` INT NOT NULL,
  PRIMARY KEY (`orderNumber`),
  INDEX `orders_ibfk_1` (`customerNumber` ASC) VISIBLE,
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`customerNumber`)
    REFERENCES `salesmanagementdb`.`customers` (`customerNumber`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `salesmanagementdb`.`productlines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesmanagementdb`.`productlines` (
  `productLine` VARCHAR(50) NOT NULL,
  `textDescription` VARCHAR(4000) NULL DEFAULT NULL,
  `htmlDescription` MEDIUMTEXT NULL DEFAULT NULL,
  `image` MEDIUMBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`productLine`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `salesmanagementdb`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesmanagementdb`.`products` (
  `productCode` VARCHAR(15) NOT NULL,
  `productName` VARCHAR(70) NOT NULL,
  `productLine` VARCHAR(50) NOT NULL,
  `productScale` VARCHAR(10) NOT NULL,
  `productVendor` VARCHAR(50) NOT NULL,
  `productDescription` TEXT NOT NULL,
  `quantityInStock` SMALLINT NOT NULL,
  `buyPrice` DECIMAL(10,2) NOT NULL,
  `MSRP` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`productCode`),
  INDEX `products_ibfk_1` (`productLine` ASC) VISIBLE,
  CONSTRAINT `products_ibfk_1`
    FOREIGN KEY (`productLine`)
    REFERENCES `salesmanagementdb`.`productlines` (`productLine`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `salesmanagementdb`.`orderdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesmanagementdb`.`orderdetails` (
  `orderNumber` INT NOT NULL,
  `productCode` VARCHAR(15) NOT NULL,
  `quantityOrdered` INT NOT NULL,
  `priceEach` DECIMAL(10,2) NOT NULL,
  `orderLineNumber` SMALLINT NOT NULL,
  PRIMARY KEY (`orderNumber`, `productCode`),
  INDEX `orderdetails_ibfk_2` (`productCode` ASC) VISIBLE,
  CONSTRAINT `orderdetails_ibfk_1`
    FOREIGN KEY (`orderNumber`)
    REFERENCES `salesmanagementdb`.`orders` (`orderNumber`),
  CONSTRAINT `orderdetails_ibfk_2`
    FOREIGN KEY (`productCode`)
    REFERENCES `salesmanagementdb`.`products` (`productCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `salesmanagementdb`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesmanagementdb`.`payments` (
  `customerNumber` INT NOT NULL,
  `checkNumber` VARCHAR(50) NOT NULL,
  `paymentDate` DATE NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`customerNumber`, `checkNumber`),
  CONSTRAINT `payments_ibfk_1`
    FOREIGN KEY (`customerNumber`)
    REFERENCES `salesmanagementdb`.`customers` (`customerNumber`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `quanlysanpham` ;

-- -----------------------------------------------------
-- Table `quanlysanpham`.`chucvu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quanlysanpham`.`chucvu` (
  `MaCV` INT NOT NULL,
  `TenCV` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`MaCV`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quanlysanpham`.`phongban`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quanlysanpham`.`phongban` (
  `MaPB` INT NOT NULL,
  `TenPB` VARCHAR(45) NULL DEFAULT NULL,
  `SDTPB` VARCHAR(45) NULL DEFAULT NULL,
  `DiaChi` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`MaPB`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quanlysanpham`.`trinhdohocvan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quanlysanpham`.`trinhdohocvan` (
  `MaTrinhDoHocVan` INT NOT NULL,
  `TTDHV` VARCHAR(45) NOT NULL,
  `ChuyenNganh` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`MaTrinhDoHocVan`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quanlysanpham`.`luong`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quanlysanpham`.`luong` (
  `BacLuong` DOUBLE NOT NULL,
  `LuongCB` INT NOT NULL,
  `HSLuong` DOUBLE NOT NULL,
  `HSPhuCap` DOUBLE NOT NULL,
  PRIMARY KEY (`BacLuong`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quanlysanpham`.`nhanvien`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quanlysanpham`.`nhanvien` (
  `MaNV` INT NOT NULL,
  `HoTen` VARCHAR(45) NOT NULL,
  `SoDienThoai` VARCHAR(45) NOT NULL,
  `GioiTinh` VARCHAR(45) NOT NULL,
  `NgaySinh` VARCHAR(45) NOT NULL,
  `DanToc` VARCHAR(45) NOT NULL,
  `QueQuan` VARCHAR(45) NOT NULL,
  `MaPB` INT NOT NULL,
  `MaTrinhDoHocVan` INT NOT NULL,
  `BacLuong` DOUBLE NOT NULL,
  PRIMARY KEY (`MaNV`, `MaTrinhDoHocVan`, `BacLuong`),
  INDEX `fk_nhanvien_phongban_idx` (`MaPB` ASC) VISIBLE,
  INDEX `fk_nhanvien_trinhdohocvan1_idx` (`MaTrinhDoHocVan` ASC) VISIBLE,
  INDEX `fk_nhanvien_luong1_idx` (`BacLuong` ASC) VISIBLE,
  CONSTRAINT `fk_nhanvien_phongban`
    FOREIGN KEY (`MaPB`)
    REFERENCES `quanlysanpham`.`phongban` (`MaPB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nhanvien_trinhdohocvan1`
    FOREIGN KEY (`MaTrinhDoHocVan`)
    REFERENCES `quanlysanpham`.`trinhdohocvan` (`MaTrinhDoHocVan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nhanvien_luong1`
    FOREIGN KEY (`BacLuong`)
    REFERENCES `quanlysanpham`.`luong` (`BacLuong`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quanlysanpham`.`hopdonglaodong`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quanlysanpham`.`hopdonglaodong` (
  `MaHD` INT NOT NULL,
  `MaNV` INT NOT NULL,
  `LoaiHD` VARCHAR(45) NOT NULL,
  `TuNgay` VARCHAR(45) NOT NULL,
  `DenNgay` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`MaHD`, `MaNV`),
  INDEX `fk_hopdonglaodong_nhanvien1_idx` (`MaNV` ASC) VISIBLE,
  CONSTRAINT `fk_hopdonglaodong_nhanvien1`
    FOREIGN KEY (`MaNV`)
    REFERENCES `quanlysanpham`.`nhanvien` (`MaNV`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `quanlysanpham`.`chucvu_has_nhanvien`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quanlysanpham`.`chucvu_has_nhanvien` (
  `chucvu_MaCV` INT NOT NULL,
  `nhanvien_MaNV` INT NOT NULL,
  PRIMARY KEY (`chucvu_MaCV`, `nhanvien_MaNV`),
  INDEX `fk_chucvu_has_nhanvien_nhanvien1_idx` (`nhanvien_MaNV` ASC) VISIBLE,
  INDEX `fk_chucvu_has_nhanvien_chucvu1_idx` (`chucvu_MaCV` ASC) VISIBLE,
  CONSTRAINT `fk_chucvu_has_nhanvien_chucvu1`
    FOREIGN KEY (`chucvu_MaCV`)
    REFERENCES `quanlysanpham`.`chucvu` (`MaCV`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_chucvu_has_nhanvien_nhanvien1`
    FOREIGN KEY (`nhanvien_MaNV`)
    REFERENCES `quanlysanpham`.`nhanvien` (`MaNV`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
