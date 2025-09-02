-- stg 스키마 생성 및 권한 설정
CREATE SCHEMA IF NOT EXISTS stg; -- ​스테이징/원시 적재용 스키마 생성

-- branch 테이블 구조 복제 및 데이터 복사
CREATE TABLE stg.branch (LIKE public.branch INCLUDING ALL); -- ​원본 구조(제약·인덱스 포함) 복제
INSERT INTO stg.branch SELECT * FROM public.branch; -- ​데이터 복사(원본 보존)

-- member 테이블 구조 복제 및 데이터 복사
CREATE TABLE stg."member" (LIKE public."member" INCLUDING ALL); -- ​원본 member 테이블 구조 복제
INSERT INTO stg."member" SELECT * FROM public."member"; -- ​데이터 복사

-- orderdetail 테이블 구조 복제 및 데이터 복사
CREATE TABLE stg.orderdetail (LIKE public.orderdetail INCLUDING ALL); -- ​원본 order_detail 구조 복제
INSERT INTO stg.orderdetail SELECT * FROM public.orderdetail; -- ​데이터 복사

-- orders 테이블 구조 복제 및 데이터 복사
CREATE TABLE stg.orders (LIKE public.orders INCLUDING ALL); -- ​원본 orders 구조 복제
INSERT INTO stg.orders SELECT * FROM public.orders; -- ​데이터 복사

-- pizza 테이블 구조 복제 및 데이터 복사
CREATE TABLE stg.pizza (LIKE public.pizza INCLUDING ALL); -- ​원본 pizza 구조 복제
INSERT INTO stg.pizza SELECT * FROM public.pizza; -- ​데이터 복사

-- pizzatypes 테이블 구조 복제 및 데이터 복사
CREATE TABLE stg.pizzatypes (LIKE public.pizzatypes INCLUDING ALL); -- ​원본 pizza_types 구조 복제
INSERT INTO stg.pizzatypes SELECT * FROM public.pizzatypes; -- ​데이터 복사

-- pizzatypetopping 브리지 테이블 구조 복제 및 데이터 복사
CREATE TABLE stg.pizzatypetopping (LIKE public.pizzatypetopping INCLUDING ALL); -- ​원본 브리지 구조 복제
INSERT INTO stg.pizzatypetopping SELECT * FROM public.pizzatypetopping; -- ​데이터 복사

-- topping 테이블 구조 복제 및 데이터 복사
CREATE TABLE stg.topping (LIKE public.topping INCLUDING ALL); -- ​원본 topping 구조 복제
INSERT INTO stg.topping SELECT * FROM public.topping; -- ​데이터 복사