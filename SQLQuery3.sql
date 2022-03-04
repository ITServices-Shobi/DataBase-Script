USE [master]
GO
/****** Object:  Database [SHR_SHOBIGROUP_DB]    Script Date: 04-03-2022 20:46:29 ******/
CREATE DATABASE [SHR_SHOBIGROUP_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SHR_SHOBIGROUP_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SHR_SHOBIGROUP_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SHR_SHOBIGROUP_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SHR_SHOBIGROUP_DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SHR_SHOBIGROUP_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET RECOVERY FULL 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET  MULTI_USER 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET QUERY_STORE = OFF
GO
USE [SHR_SHOBIGROUP_DB]
GO
/****** Object:  UserDefinedFunction [dbo].[fnNumberToWords]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnNumberToWords](@Number as BIGINT)

    RETURNS VARCHAR(1024)

AS

BEGIN

      DECLARE @Below20 TABLE (ID int identity(0,1), Word varchar(32))

      DECLARE @Below100 TABLE (ID int identity(2,1), Word varchar(32))

      INSERT @Below20 (Word) VALUES

                        ( 'Zero'), ('One'),( 'Two' ), ( 'Three'),

                        ( 'Four' ), ( 'Five' ), ( 'Six' ), ( 'Seven' ),

                        ( 'Eight'), ( 'Nine'), ( 'Ten'), ( 'Eleven' ),

                        ( 'Twelve' ), ( 'Thirteen' ), ( 'Fourteen'),

                        ( 'Fifteen' ), ('Sixteen' ), ( 'Seventeen'),

                        ('Eighteen' ), ( 'Nineteen' )

       INSERT @Below100 VALUES ('Twenty'), ('Thirty'),('Forty'), ('Fifty'),

                               ('Sixty'), ('Seventy'), ('Eighty'), ('Ninety')

DECLARE @English varchar(1024) =

(

  SELECT Case

    WHEN @Number = 0 THEN  ''

    WHEN @Number BETWEEN 1 AND 19

      THEN (SELECT Word FROM @Below20 WHERE ID=@Number)

   WHEN @Number BETWEEN 20 AND 99  

     THEN  (SELECT Word FROM @Below100 WHERE ID=@Number/10)+ '-' +

           dbo.fnNumberToWords( @Number % 10)

   WHEN @Number BETWEEN 100 AND 999  

     THEN  (dbo.fnNumberToWords( @Number / 100))+' Hundred '+

         dbo.fnNumberToWords( @Number % 100)

   WHEN @Number BETWEEN 1000 AND 999999  

     THEN  (dbo.fnNumberToWords( @Number / 1000))+' Thousand '+

         dbo.fnNumberToWords( @Number % 1000) 

   WHEN @Number BETWEEN 1000000 AND 999999999  

     THEN  (dbo.fnNumberToWords( @Number / 1000000))+' Million '+

         dbo.fnNumberToWords( @Number % 1000000)

   WHEN @Number BETWEEN 1000000000 AND 999999999999  

     THEN  (dbo.fnNumberToWords( @Number / 1000000000))+' Billion '+

         dbo.fnNumberToWords( @Number % 1000000000)

   WHEN @Number BETWEEN 1000000000000 AND 999999999999999  

     THEN  (dbo.fnNumberToWords( @Number / 1000000000000))+' Trillion '+

         dbo.fnNumberToWords( @Number % 1000000000000)

  WHEN @Number BETWEEN 1000000000000000 AND 999999999999999999  

     THEN  (dbo.fnNumberToWords( @Number / 1000000000000000))+' Quadrillion '+

         dbo.fnNumberToWords( @Number % 1000000000000000)

  WHEN @Number BETWEEN 1000000000000000000 AND 999999999999999999999  

     THEN  (dbo.fnNumberToWords( @Number / 1000000000000000000))+' Quintillion '+

         dbo.fnNumberToWords( @Number % 1000000000000000000)

        ELSE ' INVALID INPUT' END

)



SELECT @English = RTRIM(@English)

SELECT @English = RTRIM(LEFT(@English,len(@English)-1))

                 WHERE RIGHT(@English,1)='-'

RETURN (@English)

END

GO
/****** Object:  Table [dbo].[AttandancePolicy]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttandancePolicy](
	[AttandancePolicyId] [int] IDENTITY(1,1) NOT NULL,
	[AttandancePolicyName] [varchar](500) NULL,
	[Description] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_AttandancePolicy] PRIMARY KEY CLUSTERED 
(
	[AttandancePolicyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttandancePolicyRules]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttandancePolicyRules](
	[AttandancePolicyRuleId] [int] IDENTITY(1,1) NOT NULL,
	[AttandancePolicyRulesCategoryId] [int] NULL,
	[AttandancePolicyRuleName] [varchar](500) NULL,
	[AttandancePolicyRule] [varchar](500) NULL,
	[Description] [varchar](500) NULL,
	[Example] [varchar](500) NULL,
	[MarkStatusFor] [varchar](250) NULL,
	[SendNotification] [bit] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_AttandancePolicyRules] PRIMARY KEY CLUSTERED 
(
	[AttandancePolicyRuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttandancePolicyRulesCategory]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttandancePolicyRulesCategory](
	[AttandancePolicyRulesCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[AttandancePolicyId] [int] NULL,
	[AttandancePolicyRulesCategoryName] [varchar](500) NULL,
	[Description] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_AttandancePolicyRulesCategory] PRIMARY KEY CLUSTERED 
(
	[AttandancePolicyRulesCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttandancePolicyRulesMapping]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttandancePolicyRulesMapping](
	[AttandancePolicyRulesMappingId] [int] IDENTITY(1,1) NOT NULL,
	[AttandancePolicyId] [int] NULL,
	[AttandancePolicyRulesCategoryId] [int] NULL,
	[AttandancePolicyRuleId] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_AttandancePolicyRulesMapping] PRIMARY KEY CLUSTERED 
(
	[AttandancePolicyRulesMappingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttandancePolicySetup]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttandancePolicySetup](
	[AttandancePolicySetupId] [int] IDENTITY(1,1) NOT NULL,
	[SchemeName] [varchar](500) NULL,
	[ShiftRotationPolicyId] [int] NULL,
	[WeekendPolicyId] [int] NULL,
	[SwipeCapturingMethodId] [int] NULL,
	[ActualHourComputationMethodId] [int] NULL,
	[AttendancePolicyId] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_AttandancePolicySetup] PRIMARY KEY CLUSTERED 
(
	[AttandancePolicySetupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuthorizedSignatory]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuthorizedSignatory](
	[AuthorizedSignatoryId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](250) NULL,
	[LastName] [varchar](250) NULL,
	[Designation] [varchar](250) NULL,
	[IsActive] [bit] NULL,
	[SignatureImagePath] [varchar](500) NULL,
	[SectionName] [varchar](500) NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_AuthorizedSignatory] PRIMARY KEY CLUSTERED 
(
	[AuthorizedSignatoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BankMaster]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankMaster](
	[bankMasterDataId] [int] IDENTITY(1,1) NOT NULL,
	[bankName] [varchar](250) NULL,
	[bankCode] [varchar](100) NULL,
	[IFSCCODE] [varchar](20) NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_BankMaster] PRIMARY KEY CLUSTERED 
(
	[bankMasterDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyMaster]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyMaster](
	[CompanyId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [varchar](2000) NULL,
	[CompanyAdd] [varchar](max) NULL,
	[PinCode] [varchar](50) NULL,
	[WebSiteName] [varchar](100) NULL,
	[PhoneNo] [varchar](50) NULL,
	[MobNo] [varchar](50) NULL,
	[GSTNO] [varchar](15) NULL,
	[PANNO] [varchar](50) NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[UpdateDate] [varchar](50) NULL,
	[UpdateBy] [int] NULL,
 CONSTRAINT [PK_CompanyMaster] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CreateEmpPayRollMonth]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreateEmpPayRollMonth](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PayRollMonth] [int] NULL,
	[FromPayRollPeriod] [date] NULL,
	[ToPayRollPeriod] [date] NULL,
	[Status] [bit] NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_EmpPayRollMonth] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CurrancyMaster]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrancyMaster](
	[CurrencyId] [int] IDENTITY(1,1) NOT NULL,
	[CurrencyName] [varchar](250) NULL,
	[Code] [varchar](150) NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_CurrancyMaster] PRIMARY KEY CLUSTERED 
(
	[CurrencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [varchar](250) NULL,
	[DepartmentCode] [varchar](250) NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
	[ColorCode] [int] NULL,
	[CompanyId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Designation]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Designation](
	[DesignationId] [int] IDENTITY(1,1) NOT NULL,
	[DesignationName] [varchar](250) NULL,
	[DesignationCode] [varchar](250) NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_Designation] PRIMARY KEY CLUSTERED 
(
	[DesignationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailTemplates]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailTemplates](
	[EmailTemplateId] [int] IDENTITY(1,1) NOT NULL,
	[EmailTemplateTitle] [varchar](250) NULL,
	[EmailTemplateHtml] [varchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_EmailTemplates] PRIMARY KEY CLUSTERED 
(
	[EmailTemplateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpAddress]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpAddress](
	[EmpAddressId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Address] [varchar](500) NULL,
	[Country] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[Pin] [varchar](20) NULL,
	[IsPermanentAddress] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_EmpAddress] PRIMARY KEY CLUSTERED 
(
	[EmpAddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpArrearDetails]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpArrearDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[EmployeeNumber] [nvarchar](50) NULL,
	[EmployeeName] [nvarchar](250) NULL,
	[PayrollMonth] [int] NULL,
	[EffectiveDateFrom] [date] NULL,
	[Remarks] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_EmpArrearDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpBankDetails]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpBankDetails](
	[EmpBankDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[BankEmployeeId] [int] NOT NULL,
	[BankName] [varchar](500) NULL,
	[BranchName] [varchar](500) NULL,
	[BankAccountNumber] [varchar](50) NULL,
	[IFSC] [varchar](50) NULL,
	[AccountType] [varchar](50) NULL,
	[DDPayableAt] [varchar](250) NULL,
	[PaymentType] [varchar](250) NULL,
	[NameAsPerBankRecords] [varchar](250) NULL,
	[DocumentFileName] [varchar](250) NULL,
	[VerificationStatus] [varchar](150) NULL,
	[VerifiedDate] [varchar](20) NULL,
	[VerifiedBy] [int] NULL,
	[VerificationComments] [varchar](250) NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_EmpBankDetails] PRIMARY KEY CLUSTERED 
(
	[EmpBankDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpDirectoryMappings]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpDirectoryMappings](
	[EmpDirectoryFieldMappingId] [int] IDENTITY(1,1) NOT NULL,
	[ExtensionNo] [bit] NULL,
	[Mobile] [bit] NULL,
	[EmergencyContactNo] [bit] NULL,
	[Division] [bit] NULL,
	[CostCenter] [bit] NULL,
	[Location] [bit] NULL,
	[Department] [bit] NULL,
	[HouseName] [bit] NULL,
	[AdditionalInformation] [bit] NULL,
	[EmpLevel] [bit] NULL,
	[SubLevel] [bit] NULL,
	[FunctionalGrade] [bit] NULL,
	[Grade] [bit] NULL,
	[Designation] [bit] NULL,
	[JoiningDate] [bit] NULL,
	[DateOfBirth] [bit] NULL,
	[Status] [bit] NULL,
	[ReportingTo] [bit] NULL,
	[BloodGroup] [bit] NULL,
	[Nationality] [bit] NULL,
	[MaritalStatus] [bit] NULL,
	[AnnualCTC] [bit] NULL,
 CONSTRAINT [PK_EmpDirectoryMappings] PRIMARY KEY CLUSTERED 
(
	[EmpDirectoryFieldMappingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpDocuments]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpDocuments](
	[EmpDocumentId] [int] IDENTITY(1,1) NOT NULL,
	[DocEmployeeId] [int] NOT NULL,
	[EmpDoumentName] [varchar](250) NULL,
	[DocumentCategory] [varchar](250) NULL,
	[DocumentFilePath] [varchar](500) NULL,
	[VerificationStatus] [varchar](150) NULL,
	[VerifiedDate] [varchar](20) NULL,
	[VerifiedBy] [int] NULL,
	[VerificationComments] [varchar](250) NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_EmpDocuments] PRIMARY KEY CLUSTERED 
(
	[EmpDocumentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpEducationDetails]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpEducationDetails](
	[EmpEducationId] [int] IDENTITY(1,1) NOT NULL,
	[EduEmployeeId] [int] NOT NULL,
	[Degree] [varchar](50) NULL,
	[Program] [varchar](250) NULL,
	[NameOfInstitute] [varchar](250) NULL,
	[PassingYear] [varchar](20) NULL,
	[Percentage] [varchar](20) NULL,
	[DocumentFileName] [varchar](500) NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
	[VerificationStatus] [varchar](150) NULL,
	[VerifiedDate] [varchar](20) NULL,
	[VerifiedBy] [int] NULL,
	[VerificationComments] [varchar](250) NULL,
 CONSTRAINT [PK_EmpEducationDetails] PRIMARY KEY CLUSTERED 
(
	[EmpEducationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpGeneralSettings]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpGeneralSettings](
	[EmpGeneralSettingId] [int] IDENTITY(1,1) NOT NULL,
	[ProbationPeriod] [int] NULL,
	[EmployeeRetirementAgeInYears] [int] NULL,
 CONSTRAINT [PK_EmpGeneralSettings] PRIMARY KEY CLUSTERED 
(
	[EmpGeneralSettingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpInfoConfiguration]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpInfoConfiguration](
	[EmpInfoConfigurationId] [int] IDENTITY(1,1) NOT NULL,
	[EmpInfoSectionId] [int] NULL,
	[EmpInfoConfigItem] [varchar](500) NULL,
	[SetToDisplay] [bit] NULL,
	[SetToMandatory] [bit] NULL,
	[SetForAttachmentsDisplay] [bit] NULL,
	[SetForAttachmentsMandatory] [bit] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_EmpInfoConfiguration] PRIMARY KEY CLUSTERED 
(
	[EmpInfoConfigurationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpInfoSections]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpInfoSections](
	[EmpInfoSectionId] [int] IDENTITY(1,1) NOT NULL,
	[EmpInfoSectionName] [varchar](500) NULL,
	[Description] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_EmpInfoSections] PRIMARY KEY CLUSTERED 
(
	[EmpInfoSectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpLeavingReasons]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpLeavingReasons](
	[EmpLeavingReasonId] [int] IDENTITY(1,1) NOT NULL,
	[EmpLeavingReason] [varchar](250) NULL,
	[Description] [varchar](250) NULL,
	[PFCode] [varchar](250) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[Createdby] [int] NULL,
 CONSTRAINT [PK_EmpLeavingReasons] PRIMARY KEY CLUSTERED 
(
	[EmpLeavingReasonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpLOPDetails]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpLOPDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[EmployeeNumber] [nvarchar](50) NULL,
	[EmployeeName] [nvarchar](250) NULL,
	[LOPMonth] [int] NULL,
	[TotalLOPDays] [nvarchar](250) NULL,
	[Remarks] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_EmpLOPDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyId] [int] NULL,
	[EmployeeNumber] [int] NULL,
	[FirstName] [varchar](250) NULL,
	[MiddleName] [varchar](250) NULL,
	[LastName] [varchar](250) NULL,
	[ContactNumber] [varchar](20) NULL,
	[AlternateNumber] [varchar](20) NULL,
	[EmergencyContactName] [varchar](100) NULL,
	[EmergencyNumber] [varchar](20) NULL,
	[Email] [varchar](250) NULL,
	[PersonalEmail] [varchar](250) NULL,
	[Gender] [varchar](20) NULL,
	[BloodGroup] [varchar](10) NULL,
	[Religion] [varchar](20) NULL,
	[DateOfBirth] [varchar](20) NULL,
	[PlaceOfBirth] [varchar](50) NULL,
	[EmployeeProfilePhoto] [varchar](500) NULL,
	[SpouseName] [varchar](100) NULL,
	[FathersName] [varchar](100) NULL,
	[MothersName] [varchar](100) NULL,
	[NomineeName] [varchar](100) NULL,
	[NomineeContactNumber] [varchar](20) NULL,
	[NomineeRelation] [varchar](100) NULL,
	[NomineeDOB] [varchar](20) NULL,
	[ProbationPeriod] [varchar](100) NULL,
	[ReportingManager] [varchar](100) NULL,
	[DateOfJoining] [varchar](20) NULL,
	[ConfirmationDate] [varchar](20) NULL,
	[EmployeeStatus] [varchar](100) NULL,
	[MaritalStatus] [varchar](20) NULL,
	[MarriageDate] [varchar](20) NULL,
	[Department] [varchar](250) NULL,
	[Designation] [varchar](250) NULL,
	[Grade] [varchar](250) NULL,
	[FunctionalGrade] [varchar](250) NULL,
	[Level] [varchar](250) NULL,
	[SubLevel] [varchar](250) NULL,
	[Location] [varchar](250) NULL,
	[CostCenter] [varchar](250) NULL,
	[PANNumber] [varchar](50) NULL,
	[PANName] [varchar](250) NULL,
	[AdharCardNumber] [varchar](50) NULL,
	[AdharCardName] [varchar](250) NULL,
	[PassportNumber] [varchar](250) NULL,
	[PassportExpiryDate] [varchar](20) NULL,
	[PFNumber] [varchar](50) NULL,
	[UANNumber] [varchar](50) NULL,
	[IncludeESI] [bit] NULL,
	[IncludeLWF] [bit] NULL,
	[PaymentMethod] [varchar](100) NULL,
	[IsSelfOnboarding] [bit] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
	[DateOfResignation] [varchar](20) NULL,
	[DateOfLastWorking] [varchar](20) NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeFeeds]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeFeeds](
	[FeedsId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NULL,
	[FeedsGroupId] [int] NULL,
	[FeedsDescription] [varchar](500) NULL,
	[FeedsFileName] [varchar](500) NULL,
	[VisibilityDate] [varchar](20) NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedTime] [varchar](20) NULL,
 CONSTRAINT [PK_EmployeeFeeds] PRIMARY KEY CLUSTERED 
(
	[FeedsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpMasterItemCategory]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpMasterItemCategory](
	[EmpMasterItemCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[EmpMasterItemCategoryName] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_EmpMasterItemCategory] PRIMARY KEY CLUSTERED 
(
	[EmpMasterItemCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpMasterItems]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpMasterItems](
	[EmpMasterItemId] [int] IDENTITY(1,1) NOT NULL,
	[EmpMasterItemCategoryId] [int] NULL,
	[EmpMasterItemName] [varchar](500) NULL,
	[EmpMasterItemDescription] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_EmpMasterItems] PRIMARY KEY CLUSTERED 
(
	[EmpMasterItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpNoSeriesFormatting]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpNoSeriesFormatting](
	[EmployeeNoSeriesId] [int] IDENTITY(1,1) NOT NULL,
	[EmpSeriesName] [varchar](50) NULL,
	[SerialNo] [varchar](50) NULL,
	[Format] [varchar](250) NULL,
	[Description] [varchar](250) NULL,
	[IsActive] [bit] NULL,
	[MappingWithEmployeeStatus] [varchar](250) NULL,
 CONSTRAINT [PK_EmpNoSeriesFormatting] PRIMARY KEY CLUSTERED 
(
	[EmployeeNoSeriesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpOnboardingDetails]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpOnboardingDetails](
	[EmpOnboardingDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[ONBEmployeeId] [int] NULL,
	[BloodGroup] [varchar](20) NULL,
	[DateOfBirth] [varchar](20) NULL,
	[MaritalStatus] [varchar](30) NULL,
	[MarriageDate] [varchar](20) NULL,
	[SpouceName] [varchar](150) NULL,
	[PlaceOfBirth] [varchar](150) NULL,
	[MothersName] [varchar](150) NULL,
	[Religion] [varchar](50) NULL,
	[PhysicallyChallenged] [bit] NULL,
	[InternationalEmployee] [bit] NULL,
	[PresentAddress] [varchar](500) NULL,
	[PermanentAddress] [varchar](500) NULL,
	[AlternateContactNo] [varchar](20) NULL,
	[AlternateContactName] [varchar](150) NULL,
	[NomineeName] [varchar](250) NULL,
	[NomineeContactNumber] [varchar](20) NULL,
	[RelationWithNominee] [varchar](150) NULL,
	[NomineeDOB] [varchar](20) NULL,
	[OnboardingStatus] [int] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_EmpOnboardingDetails] PRIMARY KEY CLUSTERED 
(
	[EmpOnboardingDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpPFESICDetails]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpPFESICDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[EmployeeNumber] [nvarchar](50) NULL,
	[EmployeeName] [nvarchar](250) NULL,
	[BankName] [nvarchar](250) NULL,
	[BankID] [int] NULL,
	[BankBranch] [nvarchar](250) NULL,
	[AccountTypeID] [int] NULL,
	[AccountNo] [nvarchar](250) NULL,
	[IFSCCode] [nvarchar](250) NULL,
	[EmployeeNameAsBankRecords] [nvarchar](250) NULL,
	[IBAN] [nvarchar](250) NULL,
	[PaymentMethod] [int] NULL,
	[ESICIsApplicable] [bit] NULL,
	[ESICAccountNo] [nvarchar](250) NULL,
	[PFAccountNo] [nvarchar](250) NULL,
	[UAN] [nvarchar](250) NULL,
	[StartDate] [date] NULL,
	[PFIsApplicable] [bit] NULL,
	[AllowEPFExcessContribution] [bit] NULL,
	[AllowEPSExcessContribution] [bit] NULL,
	[ApproverID] [int] NULL,
	[Status] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_EmpPFESICDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpReimbursement]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpReimbursement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[EmployeeNumber] [int] NULL,
	[EmployeeName] [varchar](1000) NULL,
	[ComponentsType] [varchar](100) NULL,
	[EarningsTypeFromLookUp] [int] NULL,
	[Date] [date] NULL,
	[Amount] [decimal](18, 2) NULL,
	[PaymentEffectedDate] [datetime] NULL,
	[Remarks] [varchar](1000) NOT NULL,
	[Status] [varchar](50) NULL,
	[ApprovedBy] [int] NULL,
	[ApprovedDate] [date] NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_EmpReimbursement] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpSettingsCategories]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpSettingsCategories](
	[EmpSettingsCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[EmpSettingsCategoryName] [varchar](500) NULL,
	[EmpSettingsCategoryDescription] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_EmpSettingsCategories] PRIMARY KEY CLUSTERED 
(
	[EmpSettingsCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpSettingsCategoryValues]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpSettingsCategoryValues](
	[EmpSettingsCategoryValueId] [int] IDENTITY(1,1) NOT NULL,
	[EmpSettingsCategoryId] [int] NULL,
	[EmpSettingsCategoryValue] [varchar](500) NULL,
	[Description] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_EmpSettingsCategoryValues] PRIMARY KEY CLUSTERED 
(
	[EmpSettingsCategoryValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FeedsCommentsAndLike]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeedsCommentsAndLike](
	[FeedsCLId] [int] IDENTITY(1,1) NOT NULL,
	[FeedsId] [int] NULL,
	[EmployeeId] [int] NULL,
	[Comments] [varchar](500) NULL,
	[IsComment] [bit] NULL,
	[IsLike] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedTime] [varchar](20) NULL,
 CONSTRAINT [PK_FeedsCommentsAndLike] PRIMARY KEY CLUSTERED 
(
	[FeedsCLId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FeedsGroup]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeedsGroup](
	[FeedsGroupId] [int] IDENTITY(1,1) NOT NULL,
	[FeedsGroupName] [varchar](500) NULL,
	[FeedsGroupDescription] [varchar](500) NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_FeedsGroup] PRIMARY KEY CLUSTERED 
(
	[FeedsGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HolidayMaster]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HolidayMaster](
	[HolidayId] [int] IDENTITY(1,1) NOT NULL,
	[HolidayName] [varchar](50) NOT NULL,
	[HolidayDate] [varchar](20) NULL,
	[IsActive] [bit] NULL,
	[ColorCode] [varchar](20) NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeaveApplyDetails]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeaveApplyDetails](
	[EmpLeaveId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[LeaveType] [int] NOT NULL,
	[LeaveReason] [varchar](500) NULL,
	[LeaveFromDate] [varchar](20) NULL,
	[LeaveToDate] [varchar](20) NULL,
	[LeaveAppliedOn] [varchar](20) NULL,
	[LeaveStatus] [int] NOT NULL,
	[ReportingManagerUserId] [int] NULL,
	[ReportingManagerName] [varchar](250) NULL,
	[LeaveStatusChangeDate] [varchar](20) NULL,
	[LeaveStatusChangedBy] [int] NULL,
	[LeaveRejectReason] [varchar](250) NULL,
 CONSTRAINT [PK_LeaveApplyDetails] PRIMARY KEY CLUSTERED 
(
	[EmpLeaveId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeaveStatusTypes]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeaveStatusTypes](
	[LeaveStatusTypeId] [int] IDENTITY(1,1) NOT NULL,
	[LeaveStatusTypeName] [varchar](250) NULL,
	[IsActive] [bit] NULL,
	[StatusSequence] [int] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_LeaveStatusTypes] PRIMARY KEY CLUSTERED 
(
	[LeaveStatusTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeaveTypeCategory]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeaveTypeCategory](
	[LeaveTypeCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[LeaveTypeCategoryName] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_LeaveTypeCategory] PRIMARY KEY CLUSTERED 
(
	[LeaveTypeCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeaveTypes]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeaveTypes](
	[LeaveTypeId] [int] IDENTITY(1,1) NOT NULL,
	[LeaveTypeCategoryId] [int] NULL,
	[LeaveTypeName] [varchar](500) NULL,
	[Code] [varchar](150) NULL,
	[SortOrder] [varchar](150) NULL,
	[Description] [varchar](500) NULL,
	[IsEmpAllowedToApply] [bit] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_LeaveTypes] PRIMARY KEY CLUSTERED 
(
	[LeaveTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanDetails]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoanHeaderID] [int] NULL,
	[TransactionType] [int] NULL,
	[TransactionDate] [date] NULL,
	[Amount] [decimal](18, 2) NULL,
	[ToInterest] [decimal](18, 2) NULL,
	[ToPrincipal] [decimal](18, 2) NULL,
	[ActualInterest] [decimal](18, 2) NULL,
	[ActualPrincipal] [decimal](18, 2) NULL,
	[PerkValue] [decimal](18, 2) NULL,
	[PerkAmount] [decimal](18, 2) NULL,
	[PerkRate] [decimal](18, 2) NULL,
	[Remarks] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_LoanDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanHeader]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanHeader](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[EmployeeNumber] [nvarchar](50) NULL,
	[EmployeeName] [nvarchar](250) NULL,
	[DateOfLoan] [date] NULL,
	[StartFrom] [date] NULL,
	[LoanAmount] [decimal](18, 2) NULL,
	[LoanCompleted] [bit] NULL,
	[CompletedDate] [date] NULL,
	[LoanType] [int] NULL,
	[NumberOfEMI] [int] NULL,
	[MonthlyEMIAmount] [decimal](18, 2) NULL,
	[InterestRate] [decimal](18, 2) NULL,
	[DemandPromissoryNote] [bit] NULL,
	[PerquisiteRate] [decimal](18, 2) NULL,
	[LoanAccountNo] [nvarchar](250) NULL,
	[PrincipalBalance] [decimal](18, 2) NULL,
	[InterestBalance] [decimal](18, 2) NULL,
	[Remarks] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_LoanHeader] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanRepaymentDetails]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanRepaymentDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoanHeaderID] [int] NULL,
	[RepaymentDate] [date] NULL,
	[ToInterest] [decimal](18, 2) NULL,
	[ToPrincipal] [decimal](18, 2) NULL,
	[Amount] [decimal](18, 2) NULL,
	[ModifiedDate] [date] NULL,
	[Remarks] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_LoanRepaymentDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanRevisionDetails]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanRevisionDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoanRevisionID] [int] NULL,
	[EffectiveFrom] [date] NULL,
	[EffectiveTill] [date] NULL,
	[OpeningBalance] [decimal](18, 2) NULL,
	[TopUpAmount] [decimal](18, 2) NULL,
	[LoanAmount] [decimal](18, 2) NULL,
	[OverallLoanAmount] [decimal](18, 2) NULL,
	[InterestRate] [decimal](18, 2) NULL,
	[RemainingPeriod] [nvarchar](250) NULL,
	[Remarks] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_LoanRevisionDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanRevisionHeader]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanRevisionHeader](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoanHeaderID] [int] NULL,
	[LoanType] [int] NULL,
	[LoanAmount] [decimal](18, 2) NULL,
	[CurrentInterestRate] [decimal](18, 2) NULL,
	[PrincipalBalance] [decimal](18, 2) NULL,
	[NewLoanPeriod] [nvarchar](250) NULL,
	[TopUpAmount] [decimal](18, 2) NULL,
	[NewInterestRate] [decimal](18, 2) NULL,
	[TotalInstallments] [decimal](18, 2) NULL,
	[NoOfInstallmentsPaid] [decimal](18, 2) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_LoanRevisionHeader] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LookupDetailsM]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LookupDetailsM](
	[LookUpDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[LookUpId] [int] NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](max) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_LookupMDetails] PRIMARY KEY CLUSTERED 
(
	[LookUpDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LookupM]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LookupM](
	[LookUpId] [int] IDENTITY(1,1) NOT NULL,
	[LookUpCode] [varchar](50) NULL,
	[LookUpName] [varchar](50) NULL,
	[Description] [varchar](max) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_LookupM] PRIMARY KEY CLUSTERED 
(
	[LookUpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MasterDataItems]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MasterDataItems](
	[MasterDataItemId] [int] IDENTITY(1,1) NOT NULL,
	[ItemTypeId] [int] NOT NULL,
	[MasterDataItemValue] [varchar](500) NULL,
	[ItemDescription] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_MasterDataItems] PRIMARY KEY CLUSTERED 
(
	[MasterDataItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MasterDataItemTypes]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MasterDataItemTypes](
	[ItemTypeId] [int] IDENTITY(1,1) NOT NULL,
	[ItemTypeName] [varchar](250) NOT NULL,
	[Description] [varchar](250) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_MasterDataItemTypes] PRIMARY KEY CLUSTERED 
(
	[ItemTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PageAccessSetup]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PageAccessSetup](
	[PageAccessId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[PageModuleId] [int] NULL,
	[IsAllow] [bit] NULL,
	[ModifiedDate] [varchar](20) NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_PageAccessSetup] PRIMARY KEY CLUSTERED 
(
	[PageAccessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PageModules]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PageModules](
	[PageModuleId] [int] IDENTITY(1,1) NOT NULL,
	[PageModuleName] [varchar](250) NULL,
 CONSTRAINT [PK_PageModules] PRIMARY KEY CLUSTERED 
(
	[PageModuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PasswordSetupSettings]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PasswordSetupSettings](
	[PasswordSettingId] [int] IDENTITY(1,1) NOT NULL,
	[MinimumPasswordLength] [int] NULL,
	[PasswordExpiryLimitInDays] [int] NULL,
	[ExpiryReminderInDays] [int] NULL,
	[PreviousPasswordAllowCount] [int] NULL,
	[AllowedInvalidLoginAttemptsCount] [int] NULL,
	[WelcomeEmailPasswordLinkExpiryInDays] [int] NULL,
	[AllowUserToChangePasswordOnExpiry] [int] NULL,
 CONSTRAINT [PK_PasswordSetupSettings] PRIMARY KEY CLUSTERED 
(
	[PasswordSettingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Presence]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Presence](
	[PresenceId] [char](1) NOT NULL,
	[PresenceName] [varchar](250) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
	[DateOfResignation] [varchar](20) NULL,
	[DateOfLastWorking] [varchar](20) NULL,
 CONSTRAINT [PK_Presence] PRIMARY KEY CLUSTERED 
(
	[PresenceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrevEmploymentDetails]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrevEmploymentDetails](
	[PrevEmploymentDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[PrevEmployeeId] [int] NOT NULL,
	[PrevEmploymentOrder] [int] NULL,
	[PrevEmploymentName] [varchar](250) NULL,
	[PrevCompanyAddress] [varchar](500) NULL,
	[Designation] [varchar](250) NULL,
	[JoinedDate] [varchar](20) NULL,
	[LeavingDate] [varchar](20) NULL,
	[LeavingReason] [varchar](250) NULL,
	[ContactPerson1] [varchar](250) NULL,
	[ContactPerson1No] [varchar](50) NULL,
	[ContactPerson2] [varchar](250) NULL,
	[ContactPerson2No] [varchar](50) NULL,
	[ContactPerson3] [varchar](250) NULL,
	[ContactPerson3No] [varchar](50) NULL,
	[VerificationStatus] [varchar](150) NULL,
	[VerifiedDate] [varchar](20) NULL,
	[VerifiedBy] [int] NULL,
	[VerificationComments] [varchar](250) NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_PrevEmploymentDetails] PRIMARY KEY CLUSTERED 
(
	[PrevEmploymentDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PreviousEmploymentDetails]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreviousEmploymentDetails](
	[PrevEmploymentId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NULL,
	[PrevCompanyName] [varchar](250) NULL,
	[PrevCompanyDesignation] [varchar](250) NULL,
	[PrevFromDate] [varchar](20) NULL,
	[PrevToDate] [varchar](20) NULL,
	[PrevCompanyAddress] [varchar](500) NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_PreviousEmploymentDetails] PRIMARY KEY CLUSTERED 
(
	[PrevEmploymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseModuleScheme]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseModuleScheme](
	[PurchaseModuleSchemeId] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseModuleName] [varchar](500) NULL,
	[PurchaseModuleCode] [varchar](250) NULL,
	[Description] [varchar](500) NULL,
	[CreatedDate] [varchar](20) NULL,
	[Createdby] [int] NULL,
 CONSTRAINT [PK_PurchaseModuleScheme] PRIMARY KEY CLUSTERED 
(
	[PurchaseModuleSchemeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleMaster]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleMaster](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](150) NULL,
	[RoleDescription] [varchar](250) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_RoleMaster] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalaryDetails]    Script Date: 04-03-2022 20:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalaryDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[HeaderID] [int] NOT NULL,
	[Basic] [decimal](18, 2) NULL,
	[HRA] [decimal](18, 2) NULL,
	[Bonus] [decimal](18, 2) NULL,
	[OtherAllowance] [decimal](18, 2) NULL,
	[Overttime] [decimal](18, 2) NULL,
	[ProfTax] [decimal](18, 2) NULL,
	[Loan] [decimal](18, 2) NULL,
	[AdvanceSalary] [decimal](18, 2) NULL,
	[EmployeeContributionPF] [decimal](18, 2) NULL,
	[EmployeeContributionESIC] [decimal](18, 2) NULL,
	[EmployerContributionPF] [decimal](18, 2) NULL,
	[EmployerContributionESIC] [decimal](18, 2) NULL,
	[MonthlyNetPay] [decimal](18, 2) NULL,
	[MonthlyGrossPay] [decimal](18, 2) NULL,
	[AnnualGrossSalary] [decimal](18, 2) NULL,
	[AnnualGrossCTC] [decimal](18, 2) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_SalaryDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalaryHeader]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalaryHeader](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[EmployeeNumber] [nvarchar](50) NULL,
	[EmployeeName] [nvarchar](250) NULL,
	[EmployeeType] [int] NULL,
	[Gender] [int] NULL,
	[PFAvailability] [bit] NULL,
	[DOJ] [date] NULL,
	[DOB] [date] NULL,
	[LastPayrollProceesedDate] [datetime] NULL,
	[Location] [nvarchar](250) NULL,
	[PayoutMonth] [int] NULL,
	[Remarks] [nvarchar](max) NULL,
	[EffectiveStartDate] [date] NULL,
	[EffectiveEndDate] [date] NULL,
	[Status] [nvarchar](250) NULL,
	[VersionNumber] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_SalaryHeader] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalaryMonthlyStatement]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalaryMonthlyStatement](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SalaryDetailsId] [int] NULL,
	[EmployeeID] [int] NULL,
	[EmployeeNumber] [nvarchar](50) NULL,
	[EmployeeName] [nvarchar](250) NULL,
	[DOJ] [date] NULL,
	[DaysInMonth] [nvarchar](50) NULL,
	[LOPDays] [nvarchar](50) NULL,
	[TotalWorkingDays] [nvarchar](50) NULL,
	[PayoutMonthInNo] [int] NULL,
	[PayoutYR] [int] NULL,
	[PayoutMonth] [nvarchar](250) NULL,
	[VersionNumber] [int] NULL,
	[EarningsComponentsAmt] [decimal](18, 2) NULL,
	[DeductionComponentsAmt] [decimal](18, 2) NULL,
	[Basic] [decimal](18, 2) NULL,
	[HRA] [decimal](18, 2) NULL,
	[Bonus] [decimal](18, 2) NULL,
	[OtherAllowance] [decimal](18, 2) NULL,
	[Overttime] [decimal](18, 2) NULL,
	[ProfTax] [decimal](18, 2) NULL,
	[Arrears] [decimal](18, 2) NULL,
	[Reimbursement] [decimal](18, 2) NULL,
	[Loan] [decimal](18, 2) NULL,
	[AdvanceSalary] [decimal](18, 2) NULL,
	[MonthlyPF] [decimal](18, 2) NULL,
	[MonthlyESIC] [decimal](18, 2) NULL,
	[MonthlyNetPay] [decimal](18, 2) NULL,
	[MonthlyGrossPay] [decimal](18, 2) NULL,
	[TotalDeduction] [decimal](18, 2) NULL,
	[NetPay] [decimal](18, 2) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[MailSendStatus] [varchar](50) NULL,
 CONSTRAINT [PK_SalaryMonthlyStatement] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SettingsDataItems]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SettingsDataItems](
	[SettingsDataItemId] [int] IDENTITY(1,1) NOT NULL,
	[SettingsItemTypeId] [int] NOT NULL,
	[SettingsDataItemName] [varchar](500) NULL,
	[SettingsDataItemValue] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_SettingsDataItems] PRIMARY KEY CLUSTERED 
(
	[SettingsDataItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SettingsDataItemTypes]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SettingsDataItemTypes](
	[SettingsItemTypeId] [int] IDENTITY(1,1) NOT NULL,
	[SettingsItemTypeName] [varchar](250) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_SettingsDataItemTypes] PRIMARY KEY CLUSTERED 
(
	[SettingsItemTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shift]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shift](
	[ShiftId] [int] IDENTITY(1,1) NOT NULL,
	[ShiftName] [varchar](250) NULL,
	[ShiftCode] [varchar](150) NULL,
	[HalfDayMinimumHours] [varchar](50) NULL,
	[FullDayMinimumHours] [varchar](50) NULL,
	[CalculateShiftHoursBasedOnScheme] [int] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_Shift] PRIMARY KEY CLUSTERED 
(
	[ShiftId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShiftHoursCalculationScheme]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShiftHoursCalculationScheme](
	[ShiftHoursCalculationSchemeId] [int] IDENTITY(1,1) NOT NULL,
	[ShiftHoursCalculationSchemeName] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[Createdby] [int] NULL,
 CONSTRAINT [PK_ShiftHoursCalculationScheme] PRIMARY KEY CLUSTERED 
(
	[ShiftHoursCalculationSchemeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShiftSessions]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShiftSessions](
	[ShiftSessionId] [int] IDENTITY(1,1) NOT NULL,
	[ShiftSessionName] [varchar](250) NULL,
	[Description] [varchar](500) NULL,
	[ShiftId] [int] NULL,
	[InTime] [varchar](20) NULL,
	[OutTime] [varchar](20) NULL,
	[GraceInTime] [varchar](20) NULL,
	[GraceOutTime] [varchar](20) NULL,
	[InMarginTime] [varchar](20) NULL,
	[OutMarginTime] [varchar](20) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [varchar](20) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_ShiftSessions] PRIMARY KEY CLUSTERED 
(
	[ShiftSessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaxLocationProfTaxMapping]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxLocationProfTaxMapping](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NULL,
	[ProfTax] [decimal](18, 2) NULL,
 CONSTRAINT [PK_TaxLocationProfTaxMapping] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimeRecordingSheetDetails]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeRecordingSheetDetails](
	[RecTimeSheetDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[EmpId] [int] NULL,
	[Date] [datetime] NULL,
	[Day] [varchar](50) NULL,
	[Month] [int] NULL,
	[DayNo] [int] NULL,
	[EmpIn] [varchar](50) NULL,
	[EmpOut] [varchar](50) NULL,
	[Total] [varchar](50) NULL,
	[EmpBreak] [varchar](50) NULL,
	[Net] [varchar](50) NULL,
	[Presence] [varchar](50) NULL,
	[AttandanceStatus] [varchar](50) NULL,
	[IsSubmitData] [bit] NULL,
	[IsActive] [bit] NULL,
	[IsApprove] [bit] NULL,
 CONSTRAINT [PK_TimeRecordingSheetDetails] PRIMARY KEY CLUSTERED 
(
	[RecTimeSheetDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserActionLog]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserActionLog](
	[SALogId] [int] IDENTITY(1,1) NOT NULL,
	[Action] [varchar](250) NULL,
	[CreatedDate] [varchar](15) NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_ActionLogDetails] PRIMARY KEY CLUSTERED 
(
	[SALogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserDetails]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDetails](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[EmployeeId] [int] NULL,
	[UserName] [varchar](50) NOT NULL,
	[UserPassword] [varchar](50) NULL,
	[FirstName] [varchar](250) NULL,
	[LastName] [varchar](250) NULL,
	[Email] [varchar](250) NULL,
	[Contact] [varchar](20) NULL,
	[ProfilePicturePath] [varchar](500) NULL,
	[IsPwdChangeFT] [bit] NULL,
	[CreatedDate] [varchar](15) NULL,
 CONSTRAINT [PK_UserDetails] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AttandancePolicy] ON 
GO
INSERT [dbo].[AttandancePolicy] ([AttandancePolicyId], [AttandancePolicyName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, N'General Policy', N'General Policy', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicy] ([AttandancePolicyId], [AttandancePolicyName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, N'ABC', N'ABC', 1, N'08-12-2021', 1)
GO
INSERT [dbo].[AttandancePolicy] ([AttandancePolicyId], [AttandancePolicyName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (3, N'ABC', N'`', 1, N'09-12-2021', 1)
GO
INSERT [dbo].[AttandancePolicy] ([AttandancePolicyId], [AttandancePolicyName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (4, N'ABCd', N'g', 0, N'09-12-2021', 1)
GO
SET IDENTITY_INSERT [dbo].[AttandancePolicy] OFF
GO
SET IDENTITY_INSERT [dbo].[AttandancePolicyRules] ON 
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, 1, N'Presence Detection
', N'If A single swipe is recorded in a day,
Then Mark the status as Present (P) for the {}', N'single swipe is present in a day, then Mark status as Present (P) for day or session', N'If A single swipe is recorded in a day,
Then Mark the status as Present (P) for the {Day}', N'Day', 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, 1, N'Continuous Absence Alert', N'If Continuous absence is recorded for more than {} 
days in a month, then notify.
', N'Notify if continuous absence is recorded for more than 1 day(s) in a month.', N'If Continuous absence is recorded for more than {1} 

days in a month, then notify.
', N'1', 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (3, 1, N'Continuous Present Alert', N'If Employee is present continuously for {} days without any weekly offs or leaves or holidays, then notify.', N'If an employee is present continuously for the specified number of days, then a notification will be sent. The recipient of the notification can be configured under Event Notification.', N'If Employee is present continuously for {5} days without any weekly offs or leaves or holidays, then notify.', N'5', 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (4, 1, N'Swipe not present
', N'If Swipe is not present,
Then Mark the status as Absent (A)', N'When swipe is not present, mark the status as Absent(A)
', N'If Swipe is not present,
Then Mark the status as Absent (A)', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (5, 1, N'Shift Roster Detection', N'Disable Automatic updation of Shift Roster', N'With this option enabled, system can not automatically update the shifts. Admin has to update manually.', N'Disable Automatic updation of Shift Roster', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (6, 2, N'Unauthorized Absence', N'If A swipe is not recognized or recorded for a session,
Then Deduct {} day(s) as {} ', N'Notify if a swipe is not recognized or recorded for a session', N'If A swipe is not recognized or recorded for a session,
Then Deduct {0.5} day(s) as {LOP}', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (7, 2, N'Half Day Minimum Hours
', N'If The actual hours for a day is less than the minimum hours defined for a half day in a shift,
Then Deduct {}  day(s) as {} And Mark the status as {} for the day. ', N'Define the attendance status and number of leaves/LOP to be deducted if an employee''s actual hours for a day is less than the minimum hours defined for full day in a shift.', N'If The actual hours for a day is less than the minimum hours defined for a half day in a shift,
Then Deduct {1}  day(s) as {LOP} And Mark the status as {Absent(A)} for the day. ', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (8, 2, N'Full Day Minimum Hours
', N'If The actual hours for a day is less than the minimum hours defined for a full day in a shift,
Then Deduct {} day(s) as {} And Mark the status as {} for the session.', N'Define the attendance status and number of leaves/LOP to be deducted if an employee''s actual hours for a day is less than the minimum hours defined for full day in a shift.
Attendance Status for a session is based on Late-In/Early-Out made by the employee.
For example, if A logs in at 09:00 and leaves by 16:00,the afternoon session will be marked as absent.If B logs in at 10:00 and leaves at 18:00,the morning session will be marked as absent.', N'If The actual hours for a day is less than the minimum hours defined for a full day in a shift,
Then Deduct {0.5} day(s) as {LOP} And Mark the status as {Absent(A)} for the session.', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (9, 2, N'In-Time Criteria', N'After {} grace instances, If No swipe is recorded till {} hours from shift start timing.
Then Deduct {} day(s) as {} And Mark the status as {Present(P)} for the session. ', N'Notify, if no swipe is recorded till 00:00 hours from shift start timing, after 2 grace instance.', N'After {2} grace instances, If No swipe is recorded till {00:00} hours from shift start timing.
Then Deduct {0} day(s) as {Leave} And Mark the status as {Present(P)} for the session.', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (10, 2, N'Out-Time Criteria', N'After {} grace instances, If Employees leaves {} hours before the shift end time.
Then Deduct {} day(s) as {} And Mark the status as {} for the session. ', N'Notify, if  employees leaves 00:00 hours before the shift end time, after 2 grace instance.', N'
After {2} grace instances, If Employees leaves {00:00} hours before the shift end time.
Then Deduct {0} day(s) as {Leave} And Mark the status as {Present(P)} for the session. ', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (11, 2, N'Late In/ Early Out', N'After First {} grace instances If Late In per day exceeds {} minutes Early Out per day exceeds {} minutes
Then Deduct {} day(s) as Per Day And Mark the status as {} for the session. ', N'Notify, if, after First 0 grace instance.', N'After First {0} grace instances If Late In per day exceeds {0} minutes Early Out per day exceeds {0} minutes
Then Deduct {0} day(s) as Per Day And Mark the status as {Present(P)} for the session. ', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (12, 2, N'Late In', N'After {} {} grace instances If Late In per day exceeds {} minutes Then Deduct {} day(s) as { } per day
And Mark the status as {} for the session.', N'Notify, if Late In exceeds 0 minute(s), after First 0 grace instance.', N'After {First} {0} grace instances If Late In per day exceeds {0} minutes Then Deduct {0} day(s) as { } per day
And Mark the status as {Present(P)} for the session.', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (13, 2, N'Early Out', N'After {} {} grace instances If Early Out per day exceeds {} minutes
Then Deduct {} day(s) as {} per day And Mark the status as {} for the session.', N'Notify, if  Early Out exceeds 0 minute(s), after 2 consecutive grace instance.', N'After {First} {0} grace instances If Early Out per day exceeds {0} minutes
Then Deduct {0} day(s) as {} per day And Mark the status as {Present(P)} for the session.', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (14, 2, N'Late In - Consecutive Days', N'After Every {} consecutive grace instances, If Late In per day of {} minutes
Then Deduct {} day(s) as {} per day And Mark the status as {} for the session. ', N'Notify, if  Late In exceeds 0 minute(s), after 2 consecutive grace instance.', N'After Every {2} consecutive grace instances, If Late In per day of {0} minutes
Then Deduct {0} day(s) as {} per day And Mark the status as {Present(P)} for the session. ', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (15, 2, N'Early Out - Consecutive Days', N'After Every {} consecutive grace instances, If Early Out per day of {} minutes
Then Deduct {} day(s) as {} per day And Mark the status as {} for the session.', N'Notify, if  Early Out exceeds 0 minute(s), after 2 consecutive grace instance.', N'After Every {2} consecutive grace instances, If Early Out per day of {0} minutes
Then Deduct {0} day(s) as {} per day And Mark the status as {Present(P)} for the session. ', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (16, 2, N'Late In/ Early Out - Consecutive Days', N'After Every {} consecutive grace instances, If Late In per day of {} minutes Early Out per day of {} minutes
Then Deduct {} day(s) as {} {} And Mark the status as {} for the session. ', N'Notify, if, after 2 consecutive grace instance.', N'After Every {2} consecutive grace instances, If Late In per day of {0} minutes Early Out per day of {0} minutes
Then Deduct {0} day(s) as {} {Per Day} And Mark the status as {Present(P)} for the session. ', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (17, 2, N'Shortfall in work hours', N'If The actual work hours is less than the required work hours (Number of work days* shift hours),
Then Deduct {} days as per the below range for the shortfall in the work hours.', N'Deduct as per the mentioned range, if there is a shortfall in work hours per month.', N'If The actual work hours is less than the required work hours (Number of work days* shift hours),
Then Deduct {} days as per the below range for the shortfall in the work hours.', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (18, 2, N'Absent Criteria for Week off  ', N'If Employee absent before Weekoff (*Consider this rule if the day before a week off is holiday and employee is absent before holiday)
Employee absent after Weekoff (*Consider this rule if the day after a week off is holiday and employee is absent after holiday)
Then Deduct{} day(s) as {} And Mark the status as Absent for the week off.', N'When there is absence on before or after the week-off then week off will be marked as absent', N'If Employee absent before Weekoff (*Consider this rule if the day before a week off is holiday and employee is absent before holiday)
Employee absent after Weekoff (*Consider this rule if the day after a week off is holiday and employee is absent after holiday)
Then Deduct{0} day(s) as {Leave} And Mark the status as Absent for the week off.', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (19, 2, N'Absent Criteria for Holiday', N'If Employee absent before Holiday (*Consider this rule if the day before a Holiday is week off and employee is absent before week off)
Employee absent after Holiday (*Consider this rule if the day after a Holiday is week off and employee is absent after week off)
Then Deduct {} day(s) as {} And Mark the status as Absent for the Holiday. ', N'Deduct 0.5 day(s) of LOP and Holiday is marked absent when absence is deducted Holiday.', N'If Employee absent before Holiday (*Consider this rule if the day before a Holiday is week off and employee is absent before week off)
Employee absent after Holiday (*Consider this rule if the day after a Holiday is week off and employee is absent after week off)
Then Deduct {0.5} day(s) as {LOP} And Mark the status as Absent for the Holiday. ', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (20, 3, N'Back-dated regularization', N'Back-dated applications should be submitted not later than {} days', N'Back-dated attendance regularization to be submitted not later than 0 days.', N'Back-dated applications should be submitted not later than {0} days', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (21, 3, N'Limit for applications in a month', N'Maximum number of day(s) employee can apply for regularization in a month {}', N'Restrict employees to apply for attendance regularization only 0 day(s) in a month', N'Maximum number of day(s) employee can apply for regularization in a month {0}', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (22, 3, N'Minimum work hours', N'Minimum of {} total work hours per day are required to apply for regularization', N'Allow employees to apply for regularization only if the total work hours is 00:00 hours.', N'Minimum of {00:00} total work hours per day are required to apply for regularization', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (23, 3, N'Zero hours restriction', N'Restrict employees from applying regularization if total work hours is greater than zero hours.', N'Allow employees to apply for regularization even if total work hours is greater than zero.', N'Restrict employees from applying regularization if total work hours is greater than zero hours.', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (24, 3, N'Self Approval ', N'Enable self approval, when an employee apply for regularization', N'Enable self approval, when an employee applies for regularization', N'Enable self approval, when an employee apply for regularization', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (25, 3, N'Limits to avail', N'Restrict employees from applying attendance regularization for {} days', N'Restrict employees from applying regularization for days', N'
Restrict employees from applying attendance regularization for {Leave, Absent...} days', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (26, 3, N'Auto Approval', N'Approve automatically after {} days', N'Enable auto approval when employee apply for regularization.', N'Approve automatically after {1} days', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRules] ([AttandancePolicyRuleId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleName], [AttandancePolicyRule], [Description], [Example], [MarkStatusFor], [SendNotification], [IsActive], [CreatedDate], [CreatedBy]) VALUES (27, 3, N'Workflow Auto Approve', N'Enable auto approval for employee under Workflow Auto Approve role', N'Enable auto approval for employee under Workflow Auto Approve role', N'Enable auto approval for employee under Workflow Auto Approve role', NULL, 0, 1, N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[AttandancePolicyRules] OFF
GO
SET IDENTITY_INSERT [dbo].[AttandancePolicyRulesCategory] ON 
GO
INSERT [dbo].[AttandancePolicyRulesCategory] ([AttandancePolicyRulesCategoryId], [AttandancePolicyId], [AttandancePolicyRulesCategoryName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, NULL, N'Attendance Status Criteria', N'Configure rules for an employee''s attendance from this page based on their swipe detection.', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRulesCategory] ([AttandancePolicyRulesCategoryId], [AttandancePolicyId], [AttandancePolicyRulesCategoryName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, NULL, N'Penalty Rules', N'Configure rules for penalties from this page based on whether a particular condition is fulfilled or not.', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRulesCategory] ([AttandancePolicyRulesCategoryId], [AttandancePolicyId], [AttandancePolicyRulesCategoryName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (3, NULL, N'Regularization Rules', N'To configure the regularization rules', 1, N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[AttandancePolicyRulesCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[AttandancePolicyRulesMapping] ON 
GO
INSERT [dbo].[AttandancePolicyRulesMapping] ([AttandancePolicyRulesMappingId], [AttandancePolicyId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleId], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, 1, 1, 4, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRulesMapping] ([AttandancePolicyRulesMappingId], [AttandancePolicyId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleId], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, 1, 2, 7, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[AttandancePolicyRulesMapping] ([AttandancePolicyRulesMappingId], [AttandancePolicyId], [AttandancePolicyRulesCategoryId], [AttandancePolicyRuleId], [IsActive], [CreatedDate], [CreatedBy]) VALUES (3, 1, 2, 8, 1, N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[AttandancePolicyRulesMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[AuthorizedSignatory] ON 
GO
INSERT [dbo].[AuthorizedSignatory] ([AuthorizedSignatoryId], [FirstName], [LastName], [Designation], [IsActive], [SignatureImagePath], [SectionName], [CreatedDate], [CreatedBy]) VALUES (1, N'Neeraj Kumar', N'Gupta', N'Head – HR, Admin & HSE', 1, N'', N'Letter Authorized Signatory', N'22-11-2020', 1)
GO
INSERT [dbo].[AuthorizedSignatory] ([AuthorizedSignatoryId], [FirstName], [LastName], [Designation], [IsActive], [SignatureImagePath], [SectionName], [CreatedDate], [CreatedBy]) VALUES (2, N'Poornima', N'Patil', N'HR Manager', 0, NULL, N'Letter Authorized Signatory', N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[AuthorizedSignatory] OFF
GO
SET IDENTITY_INSERT [dbo].[BankMaster] ON 
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (1, N'ABN AMRO Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (2, N'Abu Dhabi Commercial Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (3, N'Allahabad Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (4, N'American Express Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (5, N'Andhra Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (6, N'AXIS Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (7, N'Bank of Baroda', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (8, N'Bank of Ceylon', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (9, N'Bank of India', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (10, N'Bank of Maharashtra', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (11, N'Bank of Rajasthan', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (12, N'Barclays Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (13, N'Bharat Overseas Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (14, N'BNP PARIBAS', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (15, N'Canara Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (16, N'Central Bank of India', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (17, N'Centurion Bank of Punjab', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (18, N'Chinatrust Commercial Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (19, N'Citibank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (20, N'City Union Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (21, N'Coastal Local Area Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (22, N'Corporation Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (23, N'DBS Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (24, N'Dena Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (25, N'Deutsche Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (26, N'Development Credit Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (27, N'Dhanalakshmi Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (28, N'Federal Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (29, N'HDFC Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (30, N'HSBC', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (31, N'ICICI Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (32, N'IDBI Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (33, N'Indian Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (34, N'Indian Overseas Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (35, N'IndusInd Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (36, N'Industrial Development Bank of India', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (37, N'ING Vysya Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (38, N'Jammu & Kashmir Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (39, N'J P Morgan Chase Bank, National Association', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (40, N'Karnataka Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (41, N'Karur Vysya Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (42, N'Kotak Mahindra Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (43, N'Lakshmi Vilas Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (44, N'Lord Krishna Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (45, N'Oriental Bank of Commerce', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (46, N'Punjab National Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (47, N'Punjab & Sind Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (48, N'Reserve Bank of India', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (49, N'SBI Commercial and International Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (50, N'South Indian Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (51, N'Standard Chartered Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (52, N'State Bank of Bikaner and Jaipur', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (53, N'State Bank of Hyderabad', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (54, N'State Bank of India', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (55, N'State Bank of Indore', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (56, N'State Bank of Mauritius', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (57, N'State Bank of Mysore', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (58, N'State Bank of Patiala', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (59, N'State Bank of Saurashtra', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (60, N'State Bank of Travancore', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (61, N'Syndicate Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (62, N'TamilnadMercantile Bank Ltd.', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (63, N'The Ratnakar Bank Ltd.', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (64, N'UCO Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (65, N'Union Bank of India', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (66, N'United Bank Of India', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (67, N'UTI Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (68, N'Vijaya Bank', NULL, NULL, N'22-11-2020', 1)
GO
INSERT [dbo].[BankMaster] ([bankMasterDataId], [bankName], [bankCode], [IFSCCODE], [CreatedDate], [CreatedBy]) VALUES (69, N'Yes Bank', NULL, NULL, N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[BankMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[CompanyMaster] ON 
GO
INSERT [dbo].[CompanyMaster] ([CompanyId], [CompanyName], [CompanyAdd], [PinCode], [WebSiteName], [PhoneNo], [MobNo], [GSTNO], [PANNO], [CreatedDate], [CreatedBy], [IsActive], [UpdateDate], [UpdateBy]) VALUES (1, N'Shobi Group ', N'Plot No. 54, Survey No. 132/1,Baner Pashan Link Road,Pashan, Pune, Maharashtra,India 411021', N'411021', N'Shobigroup.com', N'', N'8275602021', N'SHB2345G3456754', N'SHB12345', N'24-11-2021', 1, 0, NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[CompanyMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[CreateEmpPayRollMonth] ON 
GO
INSERT [dbo].[CreateEmpPayRollMonth] ([Id], [PayRollMonth], [FromPayRollPeriod], [ToPayRollPeriod], [Status], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (1, 0, CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 1, 0, 1, CAST(N'2022-01-21T22:37:01.323' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[CreateEmpPayRollMonth] ([Id], [PayRollMonth], [FromPayRollPeriod], [ToPayRollPeriod], [Status], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (2, 0, CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 1, 0, 1, CAST(N'2022-01-21T22:37:23.107' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[CreateEmpPayRollMonth] ([Id], [PayRollMonth], [FromPayRollPeriod], [ToPayRollPeriod], [Status], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (3, 0, CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 1, 0, 1, CAST(N'2022-01-21T22:39:24.000' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[CreateEmpPayRollMonth] ([Id], [PayRollMonth], [FromPayRollPeriod], [ToPayRollPeriod], [Status], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (4, 0, CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 1, 0, 1, CAST(N'2022-01-21T22:39:58.110' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[CreateEmpPayRollMonth] ([Id], [PayRollMonth], [FromPayRollPeriod], [ToPayRollPeriod], [Status], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (5, 0, CAST(N'2022-02-01' AS Date), CAST(N'2022-02-28' AS Date), 1, 0, 1, CAST(N'2022-01-21T22:51:45.113' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[CreateEmpPayRollMonth] OFF
GO
SET IDENTITY_INSERT [dbo].[CurrancyMaster] ON 
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (1, N'AED', N'AED', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (2, N'Afghan Afghani', N'AFN', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (3, N'Bahraini Dinar', N'BHD', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (4, N'British Pound', N'GBP', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (5, N'CFA franc', N'XOF', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (6, N'Dollar', N'USD', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (7, N'Egyptian Pound', N'EGP', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (8, N'Ghanaian Cedi', N'GHS', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (9, N'Indian Rupee', N'INR', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (10, N'Iraqi Dinar', N'IQD', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (11, N'Japanese Yen', N'JPY', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (12, N'Jordanian Dinar', N'JOD', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (13, N'Kenyan Shilling', N'KSH', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (14, N'Kuwaiti Dinar', N'KWD', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (15, N'Lebanese Pound', N'LBP', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (16, N'Malaysian Ringgit', N'MYR', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (17, N'Omani Riyal', N'OMR', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (18, N'Pakistani Rupee', N'PKR', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (19, N'Qatari Riyal', N'QAR', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (20, N'SAR', N'SAR', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (21, N'Tanzanian Shilling', N'TZS', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (22, N'Yemeni Rial', N'YER', N'22-11-2020', 1)
GO
INSERT [dbo].[CurrancyMaster] ([CurrencyId], [CurrencyName], [Code], [CreatedDate], [CreatedBy]) VALUES (23, N'Zambian kwacha', N'ZMW', N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[CurrancyMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Department] ON 
GO
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName], [DepartmentCode], [CreatedDate], [CreatedBy], [ColorCode], [CompanyId], [IsActive]) VALUES (1, N'Admin', N'ADM', N'03-07-2021', 1, 1, 1, 1)
GO
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName], [DepartmentCode], [CreatedDate], [CreatedBy], [ColorCode], [CompanyId], [IsActive]) VALUES (2, N'Administration & HSE', N'AHSE', N'03-07-2021', 1, 2, 1, 1)
GO
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName], [DepartmentCode], [CreatedDate], [CreatedBy], [ColorCode], [CompanyId], [IsActive]) VALUES (3, N'Central Function', N'CF', N'03-07-2021', 1, 3, 1, 1)
GO
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName], [DepartmentCode], [CreatedDate], [CreatedBy], [ColorCode], [CompanyId], [IsActive]) VALUES (4, N'Corporate IT Support Center', N'CIT', N'03-07-2021', 1, 4, 1, 1)
GO
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName], [DepartmentCode], [CreatedDate], [CreatedBy], [ColorCode], [CompanyId], [IsActive]) VALUES (5, N'Finance', N'FIN', N'03-07-2021', 1, 1, 1, 1)
GO
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName], [DepartmentCode], [CreatedDate], [CreatedBy], [ColorCode], [CompanyId], [IsActive]) VALUES (6, N'HR & Admin', N'HR', N'03-07-2021', 1, 2, 1, 1)
GO
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName], [DepartmentCode], [CreatedDate], [CreatedBy], [ColorCode], [CompanyId], [IsActive]) VALUES (7, N'IT', N'IT', N'03-07-2021', 1, 3, 1, 1)
GO
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName], [DepartmentCode], [CreatedDate], [CreatedBy], [ColorCode], [CompanyId], [IsActive]) VALUES (8, N'Management', N'MGM', N'03-07-2021', 1, 4, 1, 1)
GO
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName], [DepartmentCode], [CreatedDate], [CreatedBy], [ColorCode], [CompanyId], [IsActive]) VALUES (9, N'Purchase', N'PUR', N'03-07-2021', 1, 1, 1, 1)
GO
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName], [DepartmentCode], [CreatedDate], [CreatedBy], [ColorCode], [CompanyId], [IsActive]) VALUES (10, N'Quality', N'QLT', N'03-07-2021', 1, 2, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
SET IDENTITY_INSERT [dbo].[EmailTemplates] ON 
GO
INSERT [dbo].[EmailTemplates] ([EmailTemplateId], [EmailTemplateTitle], [EmailTemplateHtml], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, N'EmployeeOnboardingTemplate', N'<h3> Dear #FullName </h3> <div>Welcome to SHOBI Group </div> <br /> <div> We are so excited to have you on board. </div> 
<div> Also, we are looking forward to helping you find your way in our company and learn more about what we do here. </div>
<div> We have created a new self-service account for you. </div>  <div> This will help you to access your Personal Details, Leave and Attendance Information.</div>
<br /> <div> You can now start by providing your information by filling a form. </div>
<a href = #CallUrl target = ''_blank''> Let''s Get Started </a> <br /> <br /> <div> Your username is  #EmployeeNumber </div>
Looking forward to working with you. <br /> <br /> <div> Warm Regards </div> <div> <h3> HR Team </h3> </div>', 1, N'15-02-2021', 1)
GO
INSERT [dbo].[EmailTemplates] ([EmailTemplateId], [EmailTemplateTitle], [EmailTemplateHtml], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, N'EmployeeOnboardingSuccessTemplate', N'<h3> Dear #FullName </h3> <div>Welcome to SHOBI Group </div> <br /> <div> We are so excited to have you on board. </div> 
<div> Your onboarding process has been successfully completed ! </div>
<div> on the SwiftHr system you can now access your Personal Details, Leave and Attendance Information.</div>
<br /> <div> <h3>Please change your temporary password on your first login.</h3> </div>
<a href = #CallUrl target = ''_blank''> Let''s Get Started </a> <br /> <br /> <div> Your username is  #EmployeeNumber </div>
Looking forward to working with you. <br /> <br /> <div> Warm Regards </div> <div> <h3> HR Team </h3> </div>', 1, N'23-07-2021', 1)
GO
SET IDENTITY_INSERT [dbo].[EmailTemplates] OFF
GO
SET IDENTITY_INSERT [dbo].[EmpDocuments] ON 
GO
INSERT [dbo].[EmpDocuments] ([EmpDocumentId], [DocEmployeeId], [EmpDoumentName], [DocumentCategory], [DocumentFilePath], [VerificationStatus], [VerifiedDate], [VerifiedBy], [VerificationComments], [CreatedDate], [CreatedBy]) VALUES (1, 1, N'EmployeeList.pdf', N'1', N'wwwroot\UploadFiles', NULL, NULL, NULL, NULL, N'15-08-2021', 1)
GO
INSERT [dbo].[EmpDocuments] ([EmpDocumentId], [DocEmployeeId], [EmpDoumentName], [DocumentCategory], [DocumentFilePath], [VerificationStatus], [VerifiedDate], [VerifiedBy], [VerificationComments], [CreatedDate], [CreatedBy]) VALUES (4, 1, N'EmployeeList (6).pdf', N'1', N'wwwroot\UploadFiles', NULL, NULL, NULL, NULL, N'15-08-2021', 1)
GO
INSERT [dbo].[EmpDocuments] ([EmpDocumentId], [DocEmployeeId], [EmpDoumentName], [DocumentCategory], [DocumentFilePath], [VerificationStatus], [VerifiedDate], [VerifiedBy], [VerificationComments], [CreatedDate], [CreatedBy]) VALUES (5, 1, N'EmployeeList (4).pdf', N'1', N'wwwroot\UploadFiles', NULL, NULL, NULL, NULL, N'15-08-2021', 1)
GO
SET IDENTITY_INSERT [dbo].[EmpDocuments] OFF
GO
SET IDENTITY_INSERT [dbo].[EmpInfoConfiguration] ON 
GO
INSERT [dbo].[EmpInfoConfiguration] ([EmpInfoConfigurationId], [EmpInfoSectionId], [EmpInfoConfigItem], [SetToDisplay], [SetToMandatory], [SetForAttachmentsDisplay], [SetForAttachmentsMandatory], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, 1, N'Personal Information', 1, 1, 0, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpInfoConfiguration] ([EmpInfoConfigurationId], [EmpInfoSectionId], [EmpInfoConfigItem], [SetToDisplay], [SetToMandatory], [SetForAttachmentsDisplay], [SetForAttachmentsMandatory], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, 1, N'Permanent Address', 1, 1, 1, 1, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpInfoConfiguration] ([EmpInfoConfigurationId], [EmpInfoSectionId], [EmpInfoConfigItem], [SetToDisplay], [SetToMandatory], [SetForAttachmentsDisplay], [SetForAttachmentsMandatory], [IsActive], [CreatedDate], [CreatedBy]) VALUES (3, 1, N'Present Address', 1, 1, 1, 1, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpInfoConfiguration] ([EmpInfoConfigurationId], [EmpInfoSectionId], [EmpInfoConfigItem], [SetToDisplay], [SetToMandatory], [SetForAttachmentsDisplay], [SetForAttachmentsMandatory], [IsActive], [CreatedDate], [CreatedBy]) VALUES (4, 1, N'Emergency Address', 1, 1, 0, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpInfoConfiguration] ([EmpInfoConfigurationId], [EmpInfoSectionId], [EmpInfoConfigItem], [SetToDisplay], [SetToMandatory], [SetForAttachmentsDisplay], [SetForAttachmentsMandatory], [IsActive], [CreatedDate], [CreatedBy]) VALUES (5, 1, N'Qualification', 1, 1, 1, 1, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpInfoConfiguration] ([EmpInfoConfigurationId], [EmpInfoSectionId], [EmpInfoConfigItem], [SetToDisplay], [SetToMandatory], [SetForAttachmentsDisplay], [SetForAttachmentsMandatory], [IsActive], [CreatedDate], [CreatedBy]) VALUES (6, 1, N'Previous Employment', 1, 0, 1, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpInfoConfiguration] ([EmpInfoConfigurationId], [EmpInfoSectionId], [EmpInfoConfigItem], [SetToDisplay], [SetToMandatory], [SetForAttachmentsDisplay], [SetForAttachmentsMandatory], [IsActive], [CreatedDate], [CreatedBy]) VALUES (7, 1, N'Permanent Account Number', 1, 0, 1, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpInfoConfiguration] ([EmpInfoConfigurationId], [EmpInfoSectionId], [EmpInfoConfigItem], [SetToDisplay], [SetToMandatory], [SetForAttachmentsDisplay], [SetForAttachmentsMandatory], [IsActive], [CreatedDate], [CreatedBy]) VALUES (8, 1, N'Aadhaar', 1, 0, 1, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpInfoConfiguration] ([EmpInfoConfigurationId], [EmpInfoSectionId], [EmpInfoConfigItem], [SetToDisplay], [SetToMandatory], [SetForAttachmentsDisplay], [SetForAttachmentsMandatory], [IsActive], [CreatedDate], [CreatedBy]) VALUES (9, 1, N'Passport', 1, 0, 1, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpInfoConfiguration] ([EmpInfoConfigurationId], [EmpInfoSectionId], [EmpInfoConfigItem], [SetToDisplay], [SetToMandatory], [SetForAttachmentsDisplay], [SetForAttachmentsMandatory], [IsActive], [CreatedDate], [CreatedBy]) VALUES (10, 1, N'Family Details', 1, 1, 0, 0, 1, N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[EmpInfoConfiguration] OFF
GO
SET IDENTITY_INSERT [dbo].[EmpInfoSections] ON 
GO
INSERT [dbo].[EmpInfoSections] ([EmpInfoSectionId], [EmpInfoSectionName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, N'Employee Onboarding Section', N'Employee Onboarding Sections', 1, N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[EmpInfoSections] OFF
GO
SET IDENTITY_INSERT [dbo].[EmpLeavingReasons] ON 
GO
INSERT [dbo].[EmpLeavingReasons] ([EmpLeavingReasonId], [EmpLeavingReason], [Description], [PFCode], [IsActive], [CreatedDate], [Createdby]) VALUES (1, N'ABANDONED', N'ABANDONED', N'CESSATION-C', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpLeavingReasons] ([EmpLeavingReasonId], [EmpLeavingReason], [Description], [PFCode], [IsActive], [CreatedDate], [Createdby]) VALUES (2, N'CONTRACT EXPIRY', N'CONTRACT EXPIRY', N'CESSATION-C', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpLeavingReasons] ([EmpLeavingReasonId], [EmpLeavingReason], [Description], [PFCode], [IsActive], [CreatedDate], [Createdby]) VALUES (3, N'DEPORTED', N'DEPORTED', N'CESSATION-C', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpLeavingReasons] ([EmpLeavingReasonId], [EmpLeavingReason], [Description], [PFCode], [IsActive], [CreatedDate], [Createdby]) VALUES (4, N'EXPIRED', N'EXPIRED', N'DEATH IN SERVICE -D', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpLeavingReasons] ([EmpLeavingReasonId], [EmpLeavingReason], [Description], [PFCode], [IsActive], [CreatedDate], [Createdby]) VALUES (5, N'OTHERS', N'OTHERS', N'CESSATION-C', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpLeavingReasons] ([EmpLeavingReasonId], [EmpLeavingReason], [Description], [PFCode], [IsActive], [CreatedDate], [Createdby]) VALUES (6, N'RESIGNED', N'RESIGNED', N'CESSATION-C', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpLeavingReasons] ([EmpLeavingReasonId], [EmpLeavingReason], [Description], [PFCode], [IsActive], [CreatedDate], [Createdby]) VALUES (7, N'RESIGNED ON LEAVE', N'RESIGNED ON LEAVE', N'CESSATION-C', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpLeavingReasons] ([EmpLeavingReasonId], [EmpLeavingReason], [Description], [PFCode], [IsActive], [CreatedDate], [Createdby]) VALUES (8, N'SICK', N'SICK', N'CESSATION-C', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpLeavingReasons] ([EmpLeavingReasonId], [EmpLeavingReason], [Description], [PFCode], [IsActive], [CreatedDate], [Createdby]) VALUES (9, N'TERMINATED', N'TERMINATED', N'CESSATION-C', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpLeavingReasons] ([EmpLeavingReasonId], [EmpLeavingReason], [Description], [PFCode], [IsActive], [CreatedDate], [Createdby]) VALUES (10, N'TERMINATION ON LEAVE', N'TERMINATION ON LEAVE', N'CESSATION-C', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpLeavingReasons] ([EmpLeavingReasonId], [EmpLeavingReason], [Description], [PFCode], [IsActive], [CreatedDate], [Createdby]) VALUES (11, N'TRANSFERRED', N'TRANSFERRED', N'CESSATION-C', 1, N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[EmpLeavingReasons] OFF
GO
SET IDENTITY_INSERT [dbo].[EmpLOPDetails] ON 
GO
INSERT [dbo].[EmpLOPDetails] ([ID], [EmployeeID], [EmployeeNumber], [EmployeeName], [LOPMonth], [TotalLOPDays], [Remarks], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (1, 1035, N'4', N'GHI ABC XYZ', 6, N'2', N'AB', 1, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EmpLOPDetails] ([ID], [EmployeeID], [EmployeeNumber], [EmployeeName], [LOPMonth], [TotalLOPDays], [Remarks], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (2, 1037, N'6', N'OPQ SDF HJY', 6, N'2.5', N'ddfg', 1, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[EmpLOPDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (1, 2, 1000, N'Sunny', N'RajivK', N'Dewan', N'8484934878', NULL, N'Sunny Dewan', N'9370903400', N'sunny.dewan@shobigroup.com', NULL, N'196', N'5', N'191', N'17-04-1978', N'Jhansi', N'Sunny R Dewan.jpg', NULL, N'', N'Kamlesh Dewan', N'Sonal Dewan', N'8600992879', N'Wife', N'23-12-1977', N'60', N'1', NULL, NULL, N'Probation', N'33', N'09-07-2013', N'Admin', N'Director', N'L6 (6A) I', N'III', N'L4', N'(7A)', NULL, N'TR0209', N'AGM884545455', NULL, N'56565656565656', NULL, NULL, NULL, N'65656565656', N'102851115822155', 0, 0, N'Bank Transfer', 1, 1, N'24-06-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (4, 2, 1002, N'Shri', N'', N'Ram', N'9370903403', NULL, N'Sudhir Kumar', N'9370903400', N'makrand.naik@shobigroup.com', NULL, N'on', NULL, NULL, N'23-01-1971', NULL, N'default-avatar.png', N'Medha Naik', N'', NULL, NULL, NULL, NULL, NULL, N'60', N'1', N'02-12-2020', N'01-12-2020', N'Probation', NULL, NULL, N'Admin', N'Director', N'L6 (6A) I', N'III', N'L4', N'(7A)', NULL, N'TR0209', N'AGM884545455', NULL, N'56565656565656', NULL, NULL, NULL, N'65656565656', N'102851115822155', 0, 0, N'Bank Transfer', 0, 1, N'04-12-2020', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (5, 14, 1001, N'Bimal', N'Prasad', N'Ambastha', N'9835036633', NULL, N'', N'', N'bimal.p.ambastha@gmail.com', NULL, N'0', NULL, NULL, N'15-07-1952', NULL, N'default-avatar.png', N'', N'', NULL, NULL, NULL, NULL, NULL, N'', N'1', NULL, NULL, N'', NULL, NULL, N'', N'', N'', N'', N'', N'0', NULL, N'0', N'', NULL, N'', NULL, NULL, NULL, N'', N'', 0, 0, N'Bank Transfer', 0, 1, N'04-12-2020', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (6, 2, 1005, N'Vivek', N'', N'Kulkarni', N'9370903405', N'8857860304', NULL, NULL, N'vivek.kulkarni@shobigroup.com', N'vivek@gmail.com', N'Male', NULL, NULL, N'06-01-1981', NULL, N'DP_2.png', N'Mansi', N'Kumar', N'Shashikala', N'Mansi', NULL, N'Wife', N'05-07-1985', NULL, NULL, N'05-01-2021', NULL, NULL, NULL, NULL, N'151', N'Director', NULL, NULL, NULL, NULL, N'135', NULL, N'87987885444', N'Vivek Kulkarni', N'8451544455445454', N'vivek kulkarni', N'5544545', N'18-12-2024', NULL, NULL, NULL, NULL, NULL, NULL, 1, N'15-12-2020', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (8, 2, 1006, N'Makrand', N'', N'Naik', N'9370903402', NULL, NULL, NULL, N'makrand.naik@shobigroup.com', NULL, N'Male', NULL, NULL, N'12-06-1978', NULL, N'default-avatar.png', NULL, N'', NULL, NULL, NULL, NULL, NULL, N'', N'1', N'06-01-2021', NULL, N'', NULL, NULL, N'', N'', N'', N'', N'', N'0', NULL, N'0', N'', NULL, N'', NULL, NULL, NULL, N'', N'', 0, 0, N'', 1, 1, N'15-12-2020', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (9, 2, 1007, N'Puran', N'', N'Khanchandani', N'9370903403', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, N'on', NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, N'', NULL, NULL, NULL, NULL, NULL, N'', N'1', NULL, NULL, N'', NULL, NULL, N'', N'', N'', N'', N'', N'0', NULL, N'0', N'', NULL, N'', NULL, NULL, NULL, N'', N'', 0, 0, N'0', 1, 1, N'15-12-2020', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (10, 2, 1008, N'Prathmesh', N'', N'Ghate', N'97845455554', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, N'0', NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, N'', NULL, NULL, NULL, NULL, NULL, N'', N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'0', N'0', N'0', NULL, N'0', N'', NULL, N'', NULL, NULL, NULL, N'', N'', 0, 0, N'0', 1, 1, N'15-12-2020', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (13, 2, 1010, N'Makrand', N'S', N'Naik', N'9370903402', N'9822979736', NULL, NULL, N'bdm@shobigroup.com', N'vivek@gmail.com', N'0', NULL, NULL, NULL, NULL, N'DP_3.png', NULL, N'Kumar', NULL, NULL, NULL, NULL, NULL, N'', N'1', NULL, NULL, NULL, NULL, NULL, N'151', NULL, N'0', N'0', N'0', N'0', N'139', N'0', N'', N'', N'', N'', N'', N'', N'', N'', 0, 0, N'0', 1, 1, N'15-12-2020', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (14, 2, 1012, N'Nikhil', N'', N'Bonde', N'7895465454', NULL, NULL, NULL, N'nikhil.bonde@shobigroup.com', NULL, N'Male', NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, N'Corporate IT Support Center', NULL, N'0', N'0', N'0', N'0', N'0', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', 1, 1, N'07-01-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (15, 2, 1013, N'Gaurav', N'', N'Shinde', N'7845658545', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, N'0', NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, N'Central Function', NULL, N'0', N'0', N'0', N'0', N'0', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', 1, 1, N'07-01-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (16, 2, 1014, N'Shantanu', NULL, N'Tamhankar', N'8755548545', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, N'Male', NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', N'05-01-2021', NULL, NULL, NULL, NULL, N'Central Function', NULL, N'0', N'0', N'0', N'0', N'0', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', 0, 1, N'07-01-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (17, 2, 1015, N'Shantanu', NULL, N'Tamhankar', N'7845658545', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, N'Male', NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', N'06-01-2021', NULL, NULL, NULL, NULL, N'Central Function', NULL, N'0', N'0', N'0', N'0', N'0', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', 1, 1, N'07-01-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (18, 2, 1016, N'Shabdika', N'', N'Singh', N'8965468655', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, N'0', NULL, NULL, NULL, NULL, N'DP_46.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, N'Central Function', NULL, N'0', N'0', N'0', N'0', N'0', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', 1, 1, N'07-01-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (19, 2, 1018, N'Chaitanya', N'', N'Kashyap', N'6666966666', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, N'0', NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, N'Central Function', NULL, N'0', N'0', N'0', N'0', N'0', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', 1, 1, N'07-01-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (20, 2, 10080, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'sdf@adsa.com', NULL, NULL, NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, N'2021-02-26', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (21, 2, 10081, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, N'0', NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, N'Admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 1, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (22, 2, 10082, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, NULL, NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, N'2021-02-26', N'', NULL, NULL, NULL, N'Admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 1, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (23, 2, 10083, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, NULL, NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, N'2021-02-26', N'', NULL, NULL, NULL, N'Admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (24, 2, 10084, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, NULL, NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, N'2021-02-28', N'', NULL, NULL, NULL, N'Admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (25, 2, 10085, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, NULL, NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, N'2021-02-28', N'', NULL, NULL, NULL, N'Administration & HSE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (26, 2, 10086, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, NULL, NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, N'2021-02-28', N'', NULL, NULL, NULL, N'Administration & HSE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (27, 2, 10087, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, NULL, NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, N'2021-02-27', N'', NULL, NULL, NULL, N'Administration & HSE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (28, 2, 10088, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, NULL, NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, N'2021-02-27', N'', NULL, NULL, NULL, N'Administration & HSE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (29, 2, 10089, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, NULL, NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, N'2021-02-26', N'', NULL, NULL, NULL, N'Administration & HSE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (30, 2, 10090, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, NULL, NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, N'2021-02-26', N'', NULL, NULL, NULL, N'Administration & HSE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (31, 2, 10091, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, NULL, NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, N'2021-02-26', N'', NULL, NULL, NULL, N'Administration & HSE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (32, 2, 10092, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, NULL, NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, N'2021-02-26', N'', NULL, NULL, NULL, N'Administration & HSE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (33, 2, 10093, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, NULL, NULL, NULL, NULL, NULL, N'DP_48.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, N'2021-02-26', N'', NULL, NULL, NULL, N'Administration & HSE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (34, 2, 10094, N'Vivek', N'', N'Kulkarni', N'7898789787', NULL, NULL, NULL, N'vivek.kulkarni@shobigroup.com', NULL, NULL, NULL, NULL, NULL, NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, N'2021-02-26', N'', NULL, NULL, NULL, N'Administration & HSE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1, N'25-02-2021', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (36, 2, 2222, N'PayRoll', N'Test', N'Process', N'8275602021', NULL, NULL, NULL, N'sunny.dewan@shobigroup.com', NULL, N'Male', NULL, NULL, N'1998-01-01', NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'156', N'2', N'1997-04-12', NULL, N'Confirmed', NULL, NULL, N'151', N'173', N'95', N'106', N'115', N'118', N'139', N'76', NULL, NULL, NULL, NULL, NULL, NULL, N'1234566', N'123456', 1, 1, N'148', 1, 1, N'04-02-2022', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (1035, 2, 4, N'GHI', N'ABC', N'XYZ', N'8275602021', NULL, NULL, NULL, N'vrunda.shah@shobigroup.com', NULL, N'Male', NULL, NULL, N'1987-06-10', NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'2', N'2020-08-04', N'', N'Confirmed', NULL, NULL, N'157', N'187', N'96', N'108', N'113', NULL, N'137', N'78', NULL, NULL, NULL, NULL, NULL, NULL, N'1234566', N'123456', 1, 1, N'148', 0, 1, N'21-02-2022', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (1036, 2, 5, N'KLM', N'', N'AVC', N'9545161758', NULL, NULL, NULL, N'pankajkhairnar9@gmail.com', NULL, N'Male', NULL, NULL, N'1987-06-10', NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'2', N'2021-04-23', N'', N'Confirmed', NULL, NULL, N'151', N'166', N'100', N'107', N'115', N'126', N'139', N'77', NULL, NULL, NULL, NULL, NULL, NULL, N'1234566', N'123456', 1, 1, N'148', 0, 1, N'21-02-2022', 1, NULL, NULL)
GO
INSERT [dbo].[Employee] ([EmployeeId], [CompanyId], [EmployeeNumber], [FirstName], [MiddleName], [LastName], [ContactNumber], [AlternateNumber], [EmergencyContactName], [EmergencyNumber], [Email], [PersonalEmail], [Gender], [BloodGroup], [Religion], [DateOfBirth], [PlaceOfBirth], [EmployeeProfilePhoto], [SpouseName], [FathersName], [MothersName], [NomineeName], [NomineeContactNumber], [NomineeRelation], [NomineeDOB], [ProbationPeriod], [ReportingManager], [DateOfJoining], [ConfirmationDate], [EmployeeStatus], [MaritalStatus], [MarriageDate], [Department], [Designation], [Grade], [FunctionalGrade], [Level], [SubLevel], [Location], [CostCenter], [PANNumber], [PANName], [AdharCardNumber], [AdharCardName], [PassportNumber], [PassportExpiryDate], [PFNumber], [UANNumber], [IncludeESI], [IncludeLWF], [PaymentMethod], [IsSelfOnboarding], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (1037, 2, 6, N'OPQ', N'SDF', N'HJY', N'9452256215', NULL, NULL, NULL, N'it@shobigroup.com', NULL, N'Male', NULL, NULL, N'1987-06-10', NULL, N'default-avatar.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'2', N'2021-12-15', N'', N'Confirmed', NULL, NULL, N'151', N'174', N'97', N'109', N'116', N'124', N'139', N'77', NULL, NULL, NULL, NULL, NULL, NULL, N'1235', N'123456', 1, 0, N'148', 0, 1, N'21-02-2022', 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[EmployeeFeeds] ON 
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (2, 6, 1, N'Happy Diwali', N'photo1.png', N'', N'17-Dec-2020', N'10:58')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (3, 6, 1, N'Happy Diwali', N'photo2.png', N'', N'17-Dec-2020', N'11:07')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (4, 6, 1, N'Happy Navratri', N'photo3.png', N'', N'17-Dec-2020', N'13:52')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (5, 13, 1, N'Diwali Festival Bash Party  ', N'photo4.png', N'', N'19-Dec-2020', N'15:32')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (1005, 13, 2, N'All are invited for New Year Bash Party', N'', N'', N'22-Dec-2020', N'03:52')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (2005, 6, 1, N'Merry Christmas', N'photo1.png', N'', N'24-Dec-2020', N'20:49')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (2006, 6, 1, N'Test', N'photo2.png', N'', N'24-Dec-2020', N'23:48')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (2007, 6, 1, N'ggg', N'photo3.png', N'', N'24-Dec-2020', N'23:56')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (2008, 6, 2, N'dfdf', N'photo4.png', N'', N'24-Dec-2020', N'23:58')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (2009, 6, 1, N'sdfdfsdf', N'photo1.png', N'', N'25-Dec-2020', N'00:02')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (2010, 6, 1, N'bnbbnnnnn', N'', N'', N'25-Dec-2020', N'00:04')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (2011, 6, 1, N'Happy New Year', N'photo2.png', N'', N'26-Dec-2020', N'22:42')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (2012, 13, 1, NULL, N'photo3.png', N'', N'02-Jan-2021', N'12:13')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (2013, 13, 3, NULL, N'photo4.png', N'', N'02-Jan-2021', N'12:18')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (2014, 6, 1, N'<p>Test Message</p>', N'', N'', N'22-Mar-2021', N'18:18')
GO
INSERT [dbo].[EmployeeFeeds] ([FeedsId], [EmployeeId], [FeedsGroupId], [FeedsDescription], [FeedsFileName], [VisibilityDate], [CreatedDate], [CreatedTime]) VALUES (2015, 6, 1, N'<p><b><i>Today''s Test Message</i></b></p>', N'finalysis.png', N'', N'24-Mar-2021', N'16:11')
GO
SET IDENTITY_INSERT [dbo].[EmployeeFeeds] OFF
GO
SET IDENTITY_INSERT [dbo].[EmpMasterItemCategory] ON 
GO
INSERT [dbo].[EmpMasterItemCategory] ([EmpMasterItemCategoryId], [EmpMasterItemCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, N'Employee Number Series', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItemCategory] ([EmpMasterItemCategoryId], [EmpMasterItemCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, N'Employee Status', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItemCategory] ([EmpMasterItemCategoryId], [EmpMasterItemCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (3, N'Department', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItemCategory] ([EmpMasterItemCategoryId], [EmpMasterItemCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (4, N'Designation', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItemCategory] ([EmpMasterItemCategoryId], [EmpMasterItemCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (5, N'Grade', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItemCategory] ([EmpMasterItemCategoryId], [EmpMasterItemCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (6, N'Functional Grade', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItemCategory] ([EmpMasterItemCategoryId], [EmpMasterItemCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (7, N'Level', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItemCategory] ([EmpMasterItemCategoryId], [EmpMasterItemCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (8, N'Sub Level', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItemCategory] ([EmpMasterItemCategoryId], [EmpMasterItemCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (9, N'Location', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItemCategory] ([EmpMasterItemCategoryId], [EmpMasterItemCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (10, N'Cost Center', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItemCategory] ([EmpMasterItemCategoryId], [EmpMasterItemCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (11, N'Payment Method', 1, N'10-12-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[EmpMasterItemCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[EmpMasterItems] ON 
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, 1, N'Manual Entry', N'Manual Entry', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, 1, N'	Permanant Employee', N'	Permanant Employee', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (3, 1, N'Temporary Employee', N'Temporary Employee', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (4, 2, N'Confirmed', N'Confirmed', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (5, 2, N'Probation', N'Probation', 1, N'10-12-2020', 1)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (6, NULL, N'Admin', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (7, NULL, N'Administration & HSE', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (8, NULL, N'Central Function', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (9, NULL, N'Corporate IT Support Center', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (10, NULL, N'Finance', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (11, NULL, N'HR & Admin', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (12, NULL, N'IT', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (13, NULL, N'Management', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (14, NULL, N'Purchase', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (15, NULL, N'Quality', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EmpMasterItems] ([EmpMasterItemId], [EmpMasterItemCategoryId], [EmpMasterItemName], [EmpMasterItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (16, NULL, N'RD1', NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[EmpMasterItems] OFF
GO
SET IDENTITY_INSERT [dbo].[EmpOnboardingDetails] ON 
GO
INSERT [dbo].[EmpOnboardingDetails] ([EmpOnboardingDetailsId], [ONBEmployeeId], [BloodGroup], [DateOfBirth], [MaritalStatus], [MarriageDate], [SpouceName], [PlaceOfBirth], [MothersName], [Religion], [PhysicallyChallenged], [InternationalEmployee], [PresentAddress], [PermanentAddress], [AlternateContactNo], [AlternateContactName], [NomineeName], [NomineeContactNumber], [RelationWithNominee], [NomineeDOB], [OnboardingStatus], [CreatedDate], [CreatedBy]) VALUES (1, 1, N'5', N'17-04-1978', N'33', N'09-07-2013', NULL, N'Jhansi', N'Kamlesh Dewan', N'191', 0, 0, N'Sunny', N'', N'9370903400', N'Sunny Dewan', N'Sonal Dewan', N'8600992879', N'Wife', N'23-12-1977', 0, N'08-08-2021', 1)
GO
INSERT [dbo].[EmpOnboardingDetails] ([EmpOnboardingDetailsId], [ONBEmployeeId], [BloodGroup], [DateOfBirth], [MaritalStatus], [MarriageDate], [SpouceName], [PlaceOfBirth], [MothersName], [Religion], [PhysicallyChallenged], [InternationalEmployee], [PresentAddress], [PermanentAddress], [AlternateContactNo], [AlternateContactName], [NomineeName], [NomineeContactNumber], [RelationWithNominee], [NomineeDOB], [OnboardingStatus], [CreatedDate], [CreatedBy]) VALUES (3, 13, N'O+', NULL, N'Male', NULL, NULL, NULL, NULL, N'Hindu', 0, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, 1, N'24-07-2021', 1)
GO
INSERT [dbo].[EmpOnboardingDetails] ([EmpOnboardingDetailsId], [ONBEmployeeId], [BloodGroup], [DateOfBirth], [MaritalStatus], [MarriageDate], [SpouceName], [PlaceOfBirth], [MothersName], [Religion], [PhysicallyChallenged], [InternationalEmployee], [PresentAddress], [PermanentAddress], [AlternateContactNo], [AlternateContactName], [NomineeName], [NomineeContactNumber], [RelationWithNominee], [NomineeDOB], [OnboardingStatus], [CreatedDate], [CreatedBy]) VALUES (4, 15, N'O+', NULL, N'Male', NULL, NULL, NULL, NULL, N'Hindu', 0, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, 1, N'24-07-2021', 1)
GO
INSERT [dbo].[EmpOnboardingDetails] ([EmpOnboardingDetailsId], [ONBEmployeeId], [BloodGroup], [DateOfBirth], [MaritalStatus], [MarriageDate], [SpouceName], [PlaceOfBirth], [MothersName], [Religion], [PhysicallyChallenged], [InternationalEmployee], [PresentAddress], [PermanentAddress], [AlternateContactNo], [AlternateContactName], [NomineeName], [NomineeContactNumber], [RelationWithNominee], [NomineeDOB], [OnboardingStatus], [CreatedDate], [CreatedBy]) VALUES (5, 10, N'O+', NULL, N'Male', NULL, NULL, NULL, NULL, N'Hindu', 0, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, 1, N'24-07-2021', 1)
GO
INSERT [dbo].[EmpOnboardingDetails] ([EmpOnboardingDetailsId], [ONBEmployeeId], [BloodGroup], [DateOfBirth], [MaritalStatus], [MarriageDate], [SpouceName], [PlaceOfBirth], [MothersName], [Religion], [PhysicallyChallenged], [InternationalEmployee], [PresentAddress], [PermanentAddress], [AlternateContactNo], [AlternateContactName], [NomineeName], [NomineeContactNumber], [RelationWithNominee], [NomineeDOB], [OnboardingStatus], [CreatedDate], [CreatedBy]) VALUES (6, 9, N'O+', NULL, N'Male', NULL, NULL, NULL, NULL, N'Hindu', 0, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, 0, N'24-07-2021', 1)
GO
INSERT [dbo].[EmpOnboardingDetails] ([EmpOnboardingDetailsId], [ONBEmployeeId], [BloodGroup], [DateOfBirth], [MaritalStatus], [MarriageDate], [SpouceName], [PlaceOfBirth], [MothersName], [Religion], [PhysicallyChallenged], [InternationalEmployee], [PresentAddress], [PermanentAddress], [AlternateContactNo], [AlternateContactName], [NomineeName], [NomineeContactNumber], [RelationWithNominee], [NomineeDOB], [OnboardingStatus], [CreatedDate], [CreatedBy]) VALUES (7, 14, N'O+', NULL, N'Male', NULL, NULL, NULL, NULL, N'Hindu', 0, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, 0, N'24-07-2021', 1)
GO
INSERT [dbo].[EmpOnboardingDetails] ([EmpOnboardingDetailsId], [ONBEmployeeId], [BloodGroup], [DateOfBirth], [MaritalStatus], [MarriageDate], [SpouceName], [PlaceOfBirth], [MothersName], [Religion], [PhysicallyChallenged], [InternationalEmployee], [PresentAddress], [PermanentAddress], [AlternateContactNo], [AlternateContactName], [NomineeName], [NomineeContactNumber], [RelationWithNominee], [NomineeDOB], [OnboardingStatus], [CreatedDate], [CreatedBy]) VALUES (8, 8, N'O+', NULL, N'Male', NULL, NULL, NULL, NULL, N'Hindu', 0, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, 0, N'24-07-2021', 1)
GO
INSERT [dbo].[EmpOnboardingDetails] ([EmpOnboardingDetailsId], [ONBEmployeeId], [BloodGroup], [DateOfBirth], [MaritalStatus], [MarriageDate], [SpouceName], [PlaceOfBirth], [MothersName], [Religion], [PhysicallyChallenged], [InternationalEmployee], [PresentAddress], [PermanentAddress], [AlternateContactNo], [AlternateContactName], [NomineeName], [NomineeContactNumber], [RelationWithNominee], [NomineeDOB], [OnboardingStatus], [CreatedDate], [CreatedBy]) VALUES (9, 21, N'O+', NULL, N'Male', NULL, NULL, NULL, NULL, N'Hindu', 0, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, 0, N'24-07-2021', 1)
GO
INSERT [dbo].[EmpOnboardingDetails] ([EmpOnboardingDetailsId], [ONBEmployeeId], [BloodGroup], [DateOfBirth], [MaritalStatus], [MarriageDate], [SpouceName], [PlaceOfBirth], [MothersName], [Religion], [PhysicallyChallenged], [InternationalEmployee], [PresentAddress], [PermanentAddress], [AlternateContactNo], [AlternateContactName], [NomineeName], [NomineeContactNumber], [RelationWithNominee], [NomineeDOB], [OnboardingStatus], [CreatedDate], [CreatedBy]) VALUES (10, 19, N'O+', NULL, N'Male', NULL, NULL, NULL, NULL, N'Hindu', 0, 0, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, 0, N'24-07-2021', 1)
GO
INSERT [dbo].[EmpOnboardingDetails] ([EmpOnboardingDetailsId], [ONBEmployeeId], [BloodGroup], [DateOfBirth], [MaritalStatus], [MarriageDate], [SpouceName], [PlaceOfBirth], [MothersName], [Religion], [PhysicallyChallenged], [InternationalEmployee], [PresentAddress], [PermanentAddress], [AlternateContactNo], [AlternateContactName], [NomineeName], [NomineeContactNumber], [RelationWithNominee], [NomineeDOB], [OnboardingStatus], [CreatedDate], [CreatedBy]) VALUES (11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL)
GO
INSERT [dbo].[EmpOnboardingDetails] ([EmpOnboardingDetailsId], [ONBEmployeeId], [BloodGroup], [DateOfBirth], [MaritalStatus], [MarriageDate], [SpouceName], [PlaceOfBirth], [MothersName], [Religion], [PhysicallyChallenged], [InternationalEmployee], [PresentAddress], [PermanentAddress], [AlternateContactNo], [AlternateContactName], [NomineeName], [NomineeContactNumber], [RelationWithNominee], [NomineeDOB], [OnboardingStatus], [CreatedDate], [CreatedBy]) VALUES (12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[EmpOnboardingDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[EmpPFESICDetails] ON 
GO
INSERT [dbo].[EmpPFESICDetails] ([ID], [EmployeeID], [EmployeeNumber], [EmployeeName], [BankName], [BankID], [BankBranch], [AccountTypeID], [AccountNo], [IFSCCode], [EmployeeNameAsBankRecords], [IBAN], [PaymentMethod], [ESICIsApplicable], [ESICAccountNo], [PFAccountNo], [UAN], [StartDate], [PFIsApplicable], [AllowEPFExcessContribution], [AllowEPSExcessContribution], [ApproverID], [Status], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (1, 36, N'2222', N'PayRoll Test Process', NULL, 1, N'Pune', 1, N'1212324', N'', N'', N'', 3, 0, N'', N'', N'', CAST(N'0001-01-01' AS Date), 0, 0, 0, NULL, NULL, 1, NULL, NULL, 0, NULL)
GO
INSERT [dbo].[EmpPFESICDetails] ([ID], [EmployeeID], [EmployeeNumber], [EmployeeName], [BankName], [BankID], [BankBranch], [AccountTypeID], [AccountNo], [IFSCCode], [EmployeeNameAsBankRecords], [IBAN], [PaymentMethod], [ESICIsApplicable], [ESICAccountNo], [PFAccountNo], [UAN], [StartDate], [PFIsApplicable], [AllowEPFExcessContribution], [AllowEPSExcessContribution], [ApproverID], [Status], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (2, 6, N'1005', N'Vivek  Kulkarni', NULL, 1, N'Pune', 1, N'1212324', N'', N'', N'', 3, 0, N'', N'', N'', CAST(N'0001-01-01' AS Date), 0, 0, 0, NULL, NULL, 1, NULL, NULL, 0, NULL)
GO
INSERT [dbo].[EmpPFESICDetails] ([ID], [EmployeeID], [EmployeeNumber], [EmployeeName], [BankName], [BankID], [BankBranch], [AccountTypeID], [AccountNo], [IFSCCode], [EmployeeNameAsBankRecords], [IBAN], [PaymentMethod], [ESICIsApplicable], [ESICAccountNo], [PFAccountNo], [UAN], [StartDate], [PFIsApplicable], [AllowEPFExcessContribution], [AllowEPSExcessContribution], [ApproverID], [Status], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (3, 1035, N'4', N'GHI ABC XYZ', NULL, 1, N'Pune', 1, N'1234567', N'', N'', N'', 3, 0, N'', N'', N'', CAST(N'0001-01-01' AS Date), 0, 0, 0, NULL, NULL, 1, NULL, NULL, 0, NULL)
GO
INSERT [dbo].[EmpPFESICDetails] ([ID], [EmployeeID], [EmployeeNumber], [EmployeeName], [BankName], [BankID], [BankBranch], [AccountTypeID], [AccountNo], [IFSCCode], [EmployeeNameAsBankRecords], [IBAN], [PaymentMethod], [ESICIsApplicable], [ESICAccountNo], [PFAccountNo], [UAN], [StartDate], [PFIsApplicable], [AllowEPFExcessContribution], [AllowEPSExcessContribution], [ApproverID], [Status], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (4, 1036, N'5', N'KLM  AVC', NULL, 1, N'Pune', 1, N'1212324', N'', N'', N'', 3, 0, N'', N'', N'', CAST(N'0001-01-01' AS Date), 0, 0, 0, NULL, NULL, 1, NULL, NULL, 0, NULL)
GO
INSERT [dbo].[EmpPFESICDetails] ([ID], [EmployeeID], [EmployeeNumber], [EmployeeName], [BankName], [BankID], [BankBranch], [AccountTypeID], [AccountNo], [IFSCCode], [EmployeeNameAsBankRecords], [IBAN], [PaymentMethod], [ESICIsApplicable], [ESICAccountNo], [PFAccountNo], [UAN], [StartDate], [PFIsApplicable], [AllowEPFExcessContribution], [AllowEPSExcessContribution], [ApproverID], [Status], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (5, 1037, N'6', N'OPQ SDF HJY', NULL, 1, N'Pune', 1, N'1234567', N'', N'', N'', 3, 0, N'', N'', N'', CAST(N'0001-01-01' AS Date), 0, 0, 0, NULL, NULL, 1, NULL, NULL, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[EmpPFESICDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[EmpReimbursement] ON 
GO
INSERT [dbo].[EmpReimbursement] ([Id], [EmployeeId], [EmployeeNumber], [EmployeeName], [ComponentsType], [EarningsTypeFromLookUp], [Date], [Amount], [PaymentEffectedDate], [Remarks], [Status], [ApprovedBy], [ApprovedDate], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (1, 1035, 4, N'GHI XYZ', N'Earnings', 1003, CAST(N'2022-01-05' AS Date), CAST(20000.00 AS Decimal(18, 2)), CAST(N'2022-01-28T00:00:00.000' AS DateTime), N'XYZ', N'Approved', 0, CAST(N'2022-03-03' AS Date), 1, 1, CAST(N'2022-03-03T20:16:05.010' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[EmpReimbursement] OFF
GO
SET IDENTITY_INSERT [dbo].[EmpSettingsCategories] ON 
GO
INSERT [dbo].[EmpSettingsCategories] ([EmpSettingsCategoryId], [EmpSettingsCategoryName], [EmpSettingsCategoryDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, N'AdditionalInformation', N'Additional Information', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategories] ([EmpSettingsCategoryId], [EmpSettingsCategoryName], [EmpSettingsCategoryDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, N'CostCenter', N'Cost Center', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategories] ([EmpSettingsCategoryId], [EmpSettingsCategoryName], [EmpSettingsCategoryDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (3, N'Department', N'Department', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategories] ([EmpSettingsCategoryId], [EmpSettingsCategoryName], [EmpSettingsCategoryDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (4, N'Designation', N'Designation', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategories] ([EmpSettingsCategoryId], [EmpSettingsCategoryName], [EmpSettingsCategoryDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (5, N'Division', N'Division', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategories] ([EmpSettingsCategoryId], [EmpSettingsCategoryName], [EmpSettingsCategoryDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (6, N'FunctionalGrade', N'Functional Grade', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategories] ([EmpSettingsCategoryId], [EmpSettingsCategoryName], [EmpSettingsCategoryDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (7, N'Grade', N'Grade', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategories] ([EmpSettingsCategoryId], [EmpSettingsCategoryName], [EmpSettingsCategoryDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (8, N'HouseName', N'House Name', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategories] ([EmpSettingsCategoryId], [EmpSettingsCategoryName], [EmpSettingsCategoryDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (9, N'Level', N'Level', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategories] ([EmpSettingsCategoryId], [EmpSettingsCategoryName], [EmpSettingsCategoryDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (10, N'Location', N'Location', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategories] ([EmpSettingsCategoryId], [EmpSettingsCategoryName], [EmpSettingsCategoryDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (11, N'SubLevel', N'Sub Level', 1, N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[EmpSettingsCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[EmpSettingsCategoryValues] ON 
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, 1, N'External', N'External', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, 1, N'Haygrade', N'Haygrade', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (3, 1, N'Intern', N'Intern', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (4, 2, N'181251', N'181251', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (5, 2, N'181252', N'181252', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (6, 2, N'181253', N'181253', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (7, 2, N'181301', N'181301', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (8, 2, N'181352', N'181352', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (9, 2, N'181356', N'181356', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (10, 2, N'181450', N'181450', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (11, 2, N'181700', N'181700', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (12, 2, N'181701', N'181701', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (13, 2, N'181702', N'181702', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (14, 2, N'181703', N'181703', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (15, 2, N'181704', N'181704', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (16, 2, N'181705', N'181705', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (17, 2, N'181706', N'181706', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (18, 2, N'181707', N'181707', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (19, 2, N'18330', N'18330', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (20, 2, N'183310', N'183310', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (21, 2, N'183320', N'183320', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (22, 2, N'183510', N'183510', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (23, 2, N'183520', N'183520', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (24, 2, N'ECE66', N'ECE66', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (25, 2, N'J20', N'J20', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (26, 2, N'J30', N'J30', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (27, 2, N'J32', N'J32', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (28, 2, N'J51', N'J51', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (29, 2, N'J70', N'J70', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (30, 2, N'MERAK SW', N'MERAK SW', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (31, 2, N'NYAB', N'NYAB', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (32, 2, N'Selectron', N'Selectron', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (33, 2, N'Test', N'Test', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (34, 2, N'TR0161', N'TR0161', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (35, 2, N'TR0200', N'TR0200', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (36, 2, N'TR0201', N'TR0201', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (37, 2, N'TR0203', N'TR0203', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (38, 2, N'TR0209', N'TR0209', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (39, 2, N'TR0210', N'TR0210', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (40, 2, N'TR0232', N'TR0232', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (41, 2, N'TR0239', N'TR0239', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (42, 2, N'TR0241', N'TR0241', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (43, 2, N'TR0242', N'TR0242', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (44, 2, N'TR0253', N'TR0253', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (45, 2, N'TR0257', N'TR0257', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (46, 2, N'TR0258', N'TR0258', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (47, 2, N'TR0259', N'TR0259', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (48, 2, N'TR0260', N'TR0260', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (49, 2, N'TR0261', N'TR0261', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (50, 3, N'Admin', N'Admin', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (51, 3, N'Administration & HSE', N'Administration & HSE', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (52, 3, N'Central Function', N'Central Function', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (53, 3, N'Corporate IT Support Center', N'Corporate IT Support Center', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (54, 3, N'Finance', N'Finance', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (55, 3, N'HR & Admin', N'HR & Admin', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (56, 3, N'IT', N'IT', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (57, 3, N'Management', N'Management', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (58, 3, N'Purchase', N'Purchase', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (59, 3, N'Quality', N'Quality', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (60, 3, N'RD1', N'RD1', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (61, 3, N'RD3', N'RD3', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (62, 3, N'RD4', N'RD4', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (63, 3, N'RD5', N'RD5', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (64, 3, N'TEST', N'TEST', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (65, 4, N'Assistant Manager', N'Assistant Manager', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (66, 4, N'Associate', N'Associate', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (67, 4, N'Component Engineer', N'Component Engineer', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (68, 4, N'Cyber Security Manager', N'Cyber Security Manager', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (69, 4, N'Deputy General Manager', N'Deputy General Manager', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (70, 4, N'Deputy Manager', N'Deputy Manager', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (71, 4, N'Director', N'Director', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (72, 4, N'Director Quality', N'Director Quality', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (73, 4, N'Embedded Developer(EXT)', N'Embedded Developer(EXT)', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (74, 4, N'Engineer', N'Engineer', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (75, 4, N'Engineering Support Associate', N'Engineering Support Associate', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (76, 4, N'Executive', N'Executive', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (77, 4, N'Executive Assistant to MD & Support to HODS', N'Executive Assistant to MD & Support to HODS', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (78, 4, N'General Manager', N'General Manager', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (79, 4, N'Head of Department', N'Head of Department', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (80, 4, N'HR Associate', N'HR Associate', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (81, 4, N'Intern', N'Intern', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (82, 4, N'Lab Technician', N'Lab Technician', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (83, 4, N'Manager', N'Manager', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (84, 4, N'Managing Director', N'Managing Director', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (85, 4, N'PM-Project Admin Supervisor', N'PM-Project Admin Supervisor', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (86, 4, N'Project Consultant', N'Project Consultant', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (87, 4, N'Project Leader', N'Project Leader', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (88, 4, N'Project Manager', N'Project Manager', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (89, 4, N'Quality Inspector', N'Quality Inspector', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (90, 4, N'Senior Engineer', N'Senior Engineer', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (91, 4, N'Senior Executive', N'Senior Executive', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (92, 4, N'Senior Lab Technician', N'Senior Lab Technician', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (93, 4, N'Senior Manager', N'Senior Manager', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (94, 4, N'Senior Project Leader', N'Senior Project Leader', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (95, 4, N'Senior Project Manager', N'Senior Project Manager', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (96, 4, N'Senior Technical Specialist', N'Senior Technical Specialist', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (97, 4, N'Senior Technician', N'Senior Technician', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (98, 4, N'Software Engineer(EXT)', N'Software Engineer(EXT)', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (99, 4, N'Technical Specialist', N'Technical Specialist', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (100, 4, N'Trainee Engineer', N'Trainee Engineer', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (101, 5, N'Finance', N'Finance', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (102, 5, N'GSI', N'GSI', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (103, 5, N'HR', N'HR', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (104, 5, N'IT', N'IT', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (105, 5, N'KB TCI-IT', N'KB TCI-IT', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (106, 5, N'PURCHASE', N'PURCHASE', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (107, 5, N'Quality', N'Quality', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (108, 5, N'RAIL', N'RAIL', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (109, 5, N'Test', N'Test', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (110, 5, N'TRUCK', N'TRUCK', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (111, 6, N'External', N'External', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (112, 6, N'I', N'I', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (113, 6, N'II', N'II', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (114, 6, N'III', N'III', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (115, 6, N'NA', N'NA', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (116, 7, N'L4(4A) I', N'L4(4A) I', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (117, 7, N'L4(4B) I', N'L4(4B) I', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (118, 7, N'L4(4B) II', N'L4(4B) II', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (119, 7, N'L5 (5A) I', N'L5 (5A) I', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (120, 7, N'L5(5A) I', N'L5(5A) I', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (121, 7, N'L5(5A) II', N'L5(5A) II', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (122, 7, N'L5(5B) I', N'L5(5B) I', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (123, 7, N'L5 (5B) II', N'L5 (5B) II', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (124, 7, N'L5(5B) II', N'L5(5B) II', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (125, 7, N'L5 (5B) III', N'L5 (5B) III', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (126, 7, N'L5(5B) III', N'L5(5B) III', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (127, 7, N'L6 (6A) I', N'L6 (6A) I', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (128, 7, N'L6(6A) I', N'L6(6A) I', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (129, 7, N'L6 (6A) II', N'L6 (6A) II', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (130, 7, N'L6(6A) II', N'L6(6A) II', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (131, 7, N'L6 (6A) III', N'L6 (6A) III', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (132, 7, N'L6(6A) III', N'L6(6A) III', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (133, 7, N'L6 (6B) I', N'L6 (6B) I', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (134, 7, N'L6(6B) I', N'L6(6B) I', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (135, 7, N'L6(6B) II', N'L6(6B) II', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (136, 7, N'L6 (6B) III', N'L6 (6B) III', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (137, 7, N'L6(6B) III', N'L6(6B) III', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (138, 7, N'L7(7A) I', N'L7(7A) I', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (139, 7, N'L7 (C)', N'L7 (C)', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (140, 7, N'NA', N'NA', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (141, 8, N'Entrpreneurship', N'Entrpreneurship', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (142, 8, N'Passion', N'Passion', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (143, 8, N'Reliability', N'Reliability', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (144, 8, N'Responsibility', N'Responsibility', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (145, 8, N'Technological Excellence', N'Technological Excellence', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (146, 9, N'External', N'External', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (147, 9, N'L3', N'L3', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (148, 9, N'L4', N'L4', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (149, 9, N'L5', N'L5', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (150, 9, N'L6', N'L6', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (151, 9, N'L7', N'L7', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (152, 9, N'NA', N'NA', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (153, 10, N'Bangalore', N'Bangalore', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (154, 10, N'Bellary', N'Bellary', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (155, 10, N'Bidar', N'Bidar', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (156, 10, N'Calicut', N'Calicut', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (157, 10, N'Chennai', N'Chennai', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (158, 10, N'Cochin', N'Cochin', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (159, 10, N'Davangere', N'Davangere', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (160, 10, N'Delhi', N'Delhi', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (161, 10, N'Doddaballapur', N'Doddaballapur', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (162, 10, N'Gulbarga', N'Gulbarga', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (163, 10, N'Guntur', N'Guntur', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (164, 10, N'Hassan', N'Hassan', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (165, 10, N'Hoskote', N'Hoskote', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (166, 10, N'Hubli', N'Hubli', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (167, 10, N'Hyderabad', N'Hyderabad', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (168, 10, N'Mandya', N'Mandya', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (169, 10, N'Mangalore', N'Mangalore', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (170, 10, N'Mumbai', N'Mumbai', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (171, 10, N'Mysore', N'Mysore', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (172, 10, N'Pune', N'Pune', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (173, 10, N'Sirsi', N'Sirsi', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (174, 10, N'Thumkur', N'Thumkur', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (175, 10, N'Tiptur', N'Tiptur', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (176, 10, N'Tirupati', N'Tirupati', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (177, 10, N'Trivandrum', N'Trivandrum', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (178, 10, N'Vijayawada', N'Vijayawada', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (179, 11, N'(4A)', N'(4A)', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (180, 11, N'(4B)', N'(4B)', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (181, 11, N'5A', N'5A', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (182, 11, N'(5A)', N'(5A)', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (183, 11, N'5B', N'5B', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (184, 11, N'(5B)', N'(5B)', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (185, 11, N'6A', N'6A', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (186, 11, N'(6A)', N'(6A)', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (187, 11, N'6B', N'6B', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (188, 11, N'(6B)', N'(6B)', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (189, 11, N'(7A)', N'(7A)', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (190, 11, N'(C)', N'(C)', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (191, 11, N'External', N'External', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[EmpSettingsCategoryValues] ([EmpSettingsCategoryValueId], [EmpSettingsCategoryId], [EmpSettingsCategoryValue], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (192, 11, N'NA', N'NA', 1, N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[EmpSettingsCategoryValues] OFF
GO
SET IDENTITY_INSERT [dbo].[FeedsCommentsAndLike] ON 
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (1, 3, 6, NULL, NULL, 0, N'17-12-2020', N'13:39')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (2, 2, 6, NULL, NULL, 0, N'17-12-2020', N'13:44')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (3, 4, 6, N'Happy Diwali', 1, 0, N'17-12-2020', N'13:52')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (4, 2, 6, N'Happy Diwali', 1, NULL, N'17-12-2020', N'13:56')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (7, 3, 13, N'Happy Diwali', 1, NULL, N'17-12-2020', N'15:39')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (8, 4, 13, N'Happy Navratri', 1, NULL, N'17-12-2020', N'15:40')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (9, 2, 13, N'Happy Diwali', 1, NULL, N'17-12-2020', N'16:14')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (10, 3, 13, N'Happy Diwali', 1, NULL, N'17-Dec-2020', N'16:31')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (11, 3, 13, N'', 1, NULL, N'17-Dec-2020', N'16:32')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (12, 2, 13, NULL, NULL, 0, N'17-Dec-2020', N'16:36')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (13, 4, 13, NULL, NULL, 0, N'17-Dec-2020', N'16:38')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (14, 5, 6, NULL, NULL, 0, N'25-Dec-2020', N'00:33')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (15, 1005, 6, NULL, NULL, 0, N'25-Dec-2020', N'00:34')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (16, 2005, 6, NULL, NULL, 0, N'25-Dec-2020', N'00:35')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (17, 2006, 6, NULL, NULL, 0, N'25-Dec-2020', N'00:35')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (18, 2007, 6, NULL, NULL, 0, N'25-Dec-2020', N'00:35')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (19, 2010, 6, NULL, NULL, 0, N'25-Dec-2020', N'00:35')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (20, 2010, 6, NULL, 1, NULL, N'25-Dec-2020', N'00:58')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (21, 2, 6, N'test', 1, 0, N'25-Dec-2020', N'19:21')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (22, 5, 6, NULL, 1, NULL, N'25-Dec-2020', N'19:29')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (23, 2005, 6, NULL, 1, NULL, N'25-Dec-2020', N'19:56')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (24, 2, 6, N'asdasd', 1, NULL, N'25-Dec-2020', N'20:17')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (25, 2, 6, N'asdasdasdasd', 1, NULL, N'25-Dec-2020', N'20:17')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (26, 1005, 6, NULL, 1, NULL, N'25-Dec-2020', N'20:17')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (27, 2, 6, N'asdsasdasd', 1, NULL, N'25-Dec-2020', N'20:18')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (28, 2005, 6, NULL, 1, NULL, N'26-Dec-2020', N'01:17')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (29, 2006, 6, N'undefined', 1, NULL, N'26-Dec-2020', N'01:20')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (30, 2010, 6, N'undefined', 1, NULL, N'26-Dec-2020', N'01:21')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (31, 2010, 6, N'undefined', 1, NULL, N'26-Dec-2020', N'01:29')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (32, 4, 6, N'undefined', 1, NULL, N'26-Dec-2020', N'01:33')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (33, 2010, 6, N'undefined', 1, NULL, N'26-Dec-2020', N'01:34')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (34, 3, 6, N'asdasd', 1, NULL, N'26-Dec-2020', N'01:35')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (35, 2008, 6, N'asdasd', 1, NULL, N'26-Dec-2020', N'01:35')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (36, 2010, 6, N'asdasd', 1, NULL, N'26-Dec-2020', N'01:35')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (37, 2009, 6, N'asd', 1, NULL, N'26-Dec-2020', N'01:35')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (38, 2008, 6, N'erwerwer', 1, NULL, N'26-Dec-2020', N'01:35')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (39, 2008, 6, NULL, NULL, 0, N'26-Dec-2020', N'01:36')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (40, 2008, 6, N'asssdsad', 1, NULL, N'26-Dec-2020', N'01:36')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (41, 2009, 6, N'aasdas', 1, NULL, N'26-Dec-2020', N'01:36')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (42, 2009, 6, NULL, NULL, 0, N'26-Dec-2020', N'01:36')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (43, 1005, 6, N'zzzzzzzzzzzzzs', 1, NULL, N'26-Dec-2020', N'01:37')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (44, 4, 6, N'sd', 1, NULL, N'26-Dec-2020', N'16:43')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (45, 3, 6, N'ewe', 1, NULL, N'26-Dec-2020', N'16:43')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (46, 4, 6, N'sdds', 1, NULL, N'26-Dec-2020', N'16:43')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (47, 1005, 6, N'adsasdsa', 1, NULL, N'26-Dec-2020', N'16:47')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (48, 2008, 6, N'dffdff', 1, NULL, N'26-Dec-2020', N'16:53')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (49, 2008, 6, N'sdfsfs', 1, NULL, N'26-Dec-2020', N'16:59')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (50, 5, 6, N'test', 1, NULL, N'26-Dec-2020', N'17:48')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (51, 2009, 6, N'Test', 1, NULL, N'26-Dec-2020', N'17:48')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (52, 1005, 6, N'tfjjjjkk', 1, NULL, N'26-Dec-2020', N'17:50')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (53, 2, 6, N'gfhggf', 1, NULL, N'26-Dec-2020', N'17:51')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (54, 2011, 6, NULL, NULL, 0, N'28-Dec-2020', N'13:10')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (55, 2011, 6, N'Happy', 1, NULL, N'28-Dec-2020', N'13:10')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (56, 2011, 13, N'Test', 1, NULL, N'28-Dec-2020', N'13:15')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (57, 2009, 13, N'Tet', 1, NULL, N'28-Dec-2020', N'13:16')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (58, 2, 13, N'tstf', 1, NULL, N'28-Dec-2020', N'13:16')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (59, 2011, 6, N'Happy', 1, NULL, N'28-Dec-2020', N'13:17')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (60, 2011, 6, N'All happy new year', 1, NULL, N'28-Dec-2020', N'13:27')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (61, 2011, 6, N'Wish you a happy new year ', 1, NULL, N'28-Dec-2020', N'13:28')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (62, 2010, 6, N'wish you many many happy returns of the day', 1, NULL, N'28-Dec-2020', N'14:10')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (63, 2009, 6, N'Wish you a very happy birthday', 1, NULL, N'28-Dec-2020', N'14:13')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (64, 2011, 6, N'“May you have a prosperous New Year.” “Wishing you a happy, healthy New Year.” “May the New Year bless you with health, wealth, and happiness.” “In the New Year, may your right hand always be stretched out in friendship, never in want.”', 1, NULL, N'28-Dec-2020', N'14:14')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (65, 2008, 6, N'Happy anniversary ', 1, NULL, N'28-Dec-2020', N'14:15')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (66, 2008, 6, N'aw erwer sfsdf sfsdfsd sdfsdf sf ', 1, NULL, N'28-Dec-2020', N'14:19')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (67, 2009, 6, N'test', 1, NULL, N'28-Dec-2020', N'15:18')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (68, 2011, 6, N'dfdf', 1, NULL, N'28-Dec-2020', N'15:20')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (69, 2011, 6, N'Happy New Year All', 1, NULL, N'28-Dec-2020', N'15:27')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (70, 2010, 13, N'Test Comment', 1, NULL, N'29-Dec-2020', N'18:19')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (71, 2010, 13, NULL, NULL, 0, N'29-Dec-2020', N'18:19')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (72, 2012, 13, NULL, NULL, 0, N'02-Jan-2021', N'12:13')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (73, 2012, 13, N'Great', 1, NULL, N'02-Jan-2021', N'12:13')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (74, 2013, 6, NULL, NULL, 0, N'07-Jan-2021', N'06:03')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (75, 4, 6, NULL, NULL, 0, N'21-Mar-2021', N'23:37')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (76, 2013, 6, NULL, NULL, 1, N'21-Mar-2021', N'23:59')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (77, 2012, 6, NULL, NULL, 1, N'21-Mar-2021', N'23:59')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (78, 2009, 6, NULL, NULL, 1, N'21-Mar-2021', N'23:59')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (79, 1005, 6, NULL, NULL, 1, N'21-Mar-2021', N'23:59')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (80, 2, 6, NULL, NULL, 1, N'21-Mar-2021', N'23:59')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (81, 2013, 6, N'Nice Photo', 1, NULL, N'22-Mar-2021', N'10:23')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (82, 2012, 6, N'Great', 1, NULL, N'22-Mar-2021', N'10:27')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (83, 2007, 6, N'Great', 1, NULL, N'22-Mar-2021', N'10:31')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (84, 2, 6, N'Test', 1, NULL, N'22-Mar-2021', N'10:32')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (85, 2015, 6, NULL, NULL, 1, N'24-Mar-2021', N'16:11')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (86, 2015, 6, N'Test Message Comment', 1, NULL, N'24-Mar-2021', N'16:11')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (87, 2015, 1, NULL, 1, NULL, N'30-Jun-2021', N'14:08')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (88, 2015, 1, NULL, NULL, 1, N'28-Jul-2021', N'01:36')
GO
INSERT [dbo].[FeedsCommentsAndLike] ([FeedsCLId], [FeedsId], [EmployeeId], [Comments], [IsComment], [IsLike], [CreatedDate], [CreatedTime]) VALUES (89, 2015, 1, N'mbvmbvmnvmn', 1, NULL, N'28-Jul-2021', N'01:37')
GO
SET IDENTITY_INSERT [dbo].[FeedsCommentsAndLike] OFF
GO
SET IDENTITY_INSERT [dbo].[FeedsGroup] ON 
GO
INSERT [dbo].[FeedsGroup] ([FeedsGroupId], [FeedsGroupName], [FeedsGroupDescription], [CreatedDate], [CreatedBy]) VALUES (1, N'Events', N'Events', N'18-12-2020', 1)
GO
INSERT [dbo].[FeedsGroup] ([FeedsGroupId], [FeedsGroupName], [FeedsGroupDescription], [CreatedDate], [CreatedBy]) VALUES (2, N'Official News', N'Official News', N'18-12-2020', 1)
GO
INSERT [dbo].[FeedsGroup] ([FeedsGroupId], [FeedsGroupName], [FeedsGroupDescription], [CreatedDate], [CreatedBy]) VALUES (3, N'Announcements', N'Announcements', N'18-12-2020', 1)
GO
INSERT [dbo].[FeedsGroup] ([FeedsGroupId], [FeedsGroupName], [FeedsGroupDescription], [CreatedDate], [CreatedBy]) VALUES (4, N'Ads', N'Ads', N'18-12-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[FeedsGroup] OFF
GO
SET IDENTITY_INSERT [dbo].[HolidayMaster] ON 
GO
INSERT [dbo].[HolidayMaster] ([HolidayId], [HolidayName], [HolidayDate], [IsActive], [ColorCode], [CreatedDate], [CreatedBy]) VALUES (2, N'Gudi Padwa', NULL, 0, N'rgb(51, 122, 183)', N'21-12-2021', 1)
GO
INSERT [dbo].[HolidayMaster] ([HolidayId], [HolidayName], [HolidayDate], [IsActive], [ColorCode], [CreatedDate], [CreatedBy]) VALUES (3, N'Holi', N'08-09-2021', 1, N'#337ab7', N'23-09-2021', 1)
GO
INSERT [dbo].[HolidayMaster] ([HolidayId], [HolidayName], [HolidayDate], [IsActive], [ColorCode], [CreatedDate], [CreatedBy]) VALUES (6, N'Diwali', N'09-09-2021', 0, N'rgb(51, 122, 183)', N'01-10-2021', 1)
GO
INSERT [dbo].[HolidayMaster] ([HolidayId], [HolidayName], [HolidayDate], [IsActive], [ColorCode], [CreatedDate], [CreatedBy]) VALUES (28, N'New Year', NULL, 0, N'rgb(51, 122, 183)', N'17-02-2022', 1)
GO
SET IDENTITY_INSERT [dbo].[HolidayMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[LeaveApplyDetails] ON 
GO
INSERT [dbo].[LeaveApplyDetails] ([EmpLeaveId], [EmployeeId], [LeaveType], [LeaveReason], [LeaveFromDate], [LeaveToDate], [LeaveAppliedOn], [LeaveStatus], [ReportingManagerUserId], [ReportingManagerName], [LeaveStatusChangeDate], [LeaveStatusChangedBy], [LeaveRejectReason]) VALUES (1, 1, 5, N'Vacation with family', N'05-01-2022', N'28-01-2022', N'28-06-2021', 3, 1, N'Sunny Dewan', N'02-09-2021', 1, N'N/a')
GO
INSERT [dbo].[LeaveApplyDetails] ([EmpLeaveId], [EmployeeId], [LeaveType], [LeaveReason], [LeaveFromDate], [LeaveToDate], [LeaveAppliedOn], [LeaveStatus], [ReportingManagerUserId], [ReportingManagerName], [LeaveStatusChangeDate], [LeaveStatusChangedBy], [LeaveRejectReason]) VALUES (2, 13, 6, N'Suffering from fever', N'29-08-2022', N'05-09-2022', N'28-12-2021', 3, 1, N'Sunny Dewan', N'28-06-2021', 1, N'N/a')
GO
INSERT [dbo].[LeaveApplyDetails] ([EmpLeaveId], [EmployeeId], [LeaveType], [LeaveReason], [LeaveFromDate], [LeaveToDate], [LeaveAppliedOn], [LeaveStatus], [ReportingManagerUserId], [ReportingManagerName], [LeaveStatusChangeDate], [LeaveStatusChangedBy], [LeaveRejectReason]) VALUES (3, 1, 12, N'Work from Home', N'28-02-2022', N'10-03-2022', N'02-01-2022', 2, 1, N'Sunny Dewan', N'18-02-2022', 1, N'N/a')
GO
INSERT [dbo].[LeaveApplyDetails] ([EmpLeaveId], [EmployeeId], [LeaveType], [LeaveReason], [LeaveFromDate], [LeaveToDate], [LeaveAppliedOn], [LeaveStatus], [ReportingManagerUserId], [ReportingManagerName], [LeaveStatusChangeDate], [LeaveStatusChangedBy], [LeaveRejectReason]) VALUES (7, 1, 7, N'Reason changed ', N'16-09-2022', N'18-09-2022', N'10-01-2022', 3, 1, N'Sunny', N'16-09-2021', NULL, N'N/a')
GO
INSERT [dbo].[LeaveApplyDetails] ([EmpLeaveId], [EmployeeId], [LeaveType], [LeaveReason], [LeaveFromDate], [LeaveToDate], [LeaveAppliedOn], [LeaveStatus], [ReportingManagerUserId], [ReportingManagerName], [LeaveStatusChangeDate], [LeaveStatusChangedBy], [LeaveRejectReason]) VALUES (8, 1, 12, N'Working Home', N'30-09-2022', N'30-09-2022', N'10-01-2022', 1, 1, N'Sunny', NULL, NULL, NULL)
GO
INSERT [dbo].[LeaveApplyDetails] ([EmpLeaveId], [EmployeeId], [LeaveType], [LeaveReason], [LeaveFromDate], [LeaveToDate], [LeaveAppliedOn], [LeaveStatus], [ReportingManagerUserId], [ReportingManagerName], [LeaveStatusChangeDate], [LeaveStatusChangedBy], [LeaveRejectReason]) VALUES (9, 1, 4, N'Worked on Sat', N'13-10-2022', N'23-10-2022', N'10-01-2022', 4, 1, N'Sunny', N'12-01-2022', NULL, N'Not Eligible')
GO
INSERT [dbo].[LeaveApplyDetails] ([EmpLeaveId], [EmployeeId], [LeaveType], [LeaveReason], [LeaveFromDate], [LeaveToDate], [LeaveAppliedOn], [LeaveStatus], [ReportingManagerUserId], [ReportingManagerName], [LeaveStatusChangeDate], [LeaveStatusChangedBy], [LeaveRejectReason]) VALUES (10, 1, 5, N'Visiting Native Place', N'27-10-2022', N'30-10-2022', N'11-01-2022', 2, 1, N'Sunny', N'12-01-2022', NULL, N'N/a')
GO
INSERT [dbo].[LeaveApplyDetails] ([EmpLeaveId], [EmployeeId], [LeaveType], [LeaveReason], [LeaveFromDate], [LeaveToDate], [LeaveAppliedOn], [LeaveStatus], [ReportingManagerUserId], [ReportingManagerName], [LeaveStatusChangeDate], [LeaveStatusChangedBy], [LeaveRejectReason]) VALUES (11, 1036, 5, N'Visiting Native Place', N'03-01-2022', N'03-01-2022', N'25-12-2021', 2, 1, N'Sunny Dewan', N'31-12-2021', 1, N'N/a')
GO
INSERT [dbo].[LeaveApplyDetails] ([EmpLeaveId], [EmployeeId], [LeaveType], [LeaveReason], [LeaveFromDate], [LeaveToDate], [LeaveAppliedOn], [LeaveStatus], [ReportingManagerUserId], [ReportingManagerName], [LeaveStatusChangeDate], [LeaveStatusChangedBy], [LeaveRejectReason]) VALUES (12, 1037, 5, N'Visiting Native Place', N'12-01-2022', N'13-01-2022', N'01-01-2022', 2, 1, N'Sunny Dewan', N'10-01-2022', 1, N'N/a')
GO
SET IDENTITY_INSERT [dbo].[LeaveApplyDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[LeaveStatusTypes] ON 
GO
INSERT [dbo].[LeaveStatusTypes] ([LeaveStatusTypeId], [LeaveStatusTypeName], [IsActive], [StatusSequence], [CreatedDate], [CreatedBy]) VALUES (1, N'Applied', 1, 1, N'30-06-2021', 1)
GO
INSERT [dbo].[LeaveStatusTypes] ([LeaveStatusTypeId], [LeaveStatusTypeName], [IsActive], [StatusSequence], [CreatedDate], [CreatedBy]) VALUES (2, N'Cancelled', 1, 2, N'30-06-2021', 1)
GO
INSERT [dbo].[LeaveStatusTypes] ([LeaveStatusTypeId], [LeaveStatusTypeName], [IsActive], [StatusSequence], [CreatedDate], [CreatedBy]) VALUES (3, N'Approved', 1, 3, N'30-06-2021', 1)
GO
INSERT [dbo].[LeaveStatusTypes] ([LeaveStatusTypeId], [LeaveStatusTypeName], [IsActive], [StatusSequence], [CreatedDate], [CreatedBy]) VALUES (4, N'Rejected', 1, 4, N'30-06-2021', 1)
GO
SET IDENTITY_INSERT [dbo].[LeaveStatusTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[LeaveTypeCategory] ON 
GO
INSERT [dbo].[LeaveTypeCategory] ([LeaveTypeCategoryId], [LeaveTypeCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, N'Earned Leave', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypeCategory] ([LeaveTypeCategoryId], [LeaveTypeCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, N'Sick Leave', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypeCategory] ([LeaveTypeCategoryId], [LeaveTypeCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (3, N'Maternity Leave', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypeCategory] ([LeaveTypeCategoryId], [LeaveTypeCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (4, N'Paternity Leave', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypeCategory] ([LeaveTypeCategoryId], [LeaveTypeCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (5, N'Comp-Off', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypeCategory] ([LeaveTypeCategoryId], [LeaveTypeCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (6, N'Custom Leave', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypeCategory] ([LeaveTypeCategoryId], [LeaveTypeCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (7, N'Loss Of Pay', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypeCategory] ([LeaveTypeCategoryId], [LeaveTypeCategoryName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (8, N'Restricted Holiday', 1, N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[LeaveTypeCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[LeaveTypes] ON 
GO
INSERT [dbo].[LeaveTypes] ([LeaveTypeId], [LeaveTypeCategoryId], [LeaveTypeName], [Code], [SortOrder], [Description], [IsEmpAllowedToApply], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, 7, N'Loss Of Pay', N'LOP', N'0', NULL, 1, 1, N'24-02-2022', 1)
GO
INSERT [dbo].[LeaveTypes] ([LeaveTypeId], [LeaveTypeCategoryId], [LeaveTypeName], [Code], [SortOrder], [Description], [IsEmpAllowedToApply], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, 6, N'Election Leave', N'ElL', N'0', NULL, 0, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypes] ([LeaveTypeId], [LeaveTypeCategoryId], [LeaveTypeName], [Code], [SortOrder], [Description], [IsEmpAllowedToApply], [IsActive], [CreatedDate], [CreatedBy]) VALUES (3, 6, N'All Purpose Leave', N'APL', N'1', NULL, 1, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypes] ([LeaveTypeId], [LeaveTypeCategoryId], [LeaveTypeName], [Code], [SortOrder], [Description], [IsEmpAllowedToApply], [IsActive], [CreatedDate], [CreatedBy]) VALUES (4, 6, N'Comp-Off', N'COF', N'1', NULL, 1, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypes] ([LeaveTypeId], [LeaveTypeCategoryId], [LeaveTypeName], [Code], [SortOrder], [Description], [IsEmpAllowedToApply], [IsActive], [CreatedDate], [CreatedBy]) VALUES (5, 6, N'Casual Leave', N'CL', N'2', NULL, 1, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypes] ([LeaveTypeId], [LeaveTypeCategoryId], [LeaveTypeName], [Code], [SortOrder], [Description], [IsEmpAllowedToApply], [IsActive], [CreatedDate], [CreatedBy]) VALUES (6, 6, N'Sick Leave', N'SL', N'2', NULL, 1, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypes] ([LeaveTypeId], [LeaveTypeCategoryId], [LeaveTypeName], [Code], [SortOrder], [Description], [IsEmpAllowedToApply], [IsActive], [CreatedDate], [CreatedBy]) VALUES (7, 1, N'Earned Leave', N'EL', N'3', NULL, 1, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypes] ([LeaveTypeId], [LeaveTypeCategoryId], [LeaveTypeName], [Code], [SortOrder], [Description], [IsEmpAllowedToApply], [IsActive], [CreatedDate], [CreatedBy]) VALUES (8, 6, N'Bereavement Leave', N'BL', N'3', NULL, 1, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypes] ([LeaveTypeId], [LeaveTypeCategoryId], [LeaveTypeName], [Code], [SortOrder], [Description], [IsEmpAllowedToApply], [IsActive], [CreatedDate], [CreatedBy]) VALUES (9, 4, N'Paternity Leave', N'PL', N'4', NULL, 1, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypes] ([LeaveTypeId], [LeaveTypeCategoryId], [LeaveTypeName], [Code], [SortOrder], [Description], [IsEmpAllowedToApply], [IsActive], [CreatedDate], [CreatedBy]) VALUES (10, 3, N'Maternity Leaves', N'ML', N'5', NULL, 1, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypes] ([LeaveTypeId], [LeaveTypeCategoryId], [LeaveTypeName], [Code], [SortOrder], [Description], [IsEmpAllowedToApply], [IsActive], [CreatedDate], [CreatedBy]) VALUES (11, 6, N'Sabbatical Leave', N'SBL', N'6', NULL, 1, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[LeaveTypes] ([LeaveTypeId], [LeaveTypeCategoryId], [LeaveTypeName], [Code], [SortOrder], [Description], [IsEmpAllowedToApply], [IsActive], [CreatedDate], [CreatedBy]) VALUES (12, 6, N'Work from Home', N'WH', N'8', NULL, 1, 1, N'21-02-2022', 1)
GO
INSERT [dbo].[LeaveTypes] ([LeaveTypeId], [LeaveTypeCategoryId], [LeaveTypeName], [Code], [SortOrder], [Description], [IsEmpAllowedToApply], [IsActive], [CreatedDate], [CreatedBy]) VALUES (13, 6, N'Work from Home', N'WH', NULL, NULL, 1, 1, N'23-02-2022', 1)
GO
INSERT [dbo].[LeaveTypes] ([LeaveTypeId], [LeaveTypeCategoryId], [LeaveTypeName], [Code], [SortOrder], [Description], [IsEmpAllowedToApply], [IsActive], [CreatedDate], [CreatedBy]) VALUES (14, 7, N'Loss Of Income', N'LOI', NULL, N'Loss Of Pay', 0, 1, N'24-02-2022', 1)
GO
SET IDENTITY_INSERT [dbo].[LeaveTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[LoanHeader] ON 
GO
INSERT [dbo].[LoanHeader] ([ID], [EmployeeID], [EmployeeNumber], [EmployeeName], [DateOfLoan], [StartFrom], [LoanAmount], [LoanCompleted], [CompletedDate], [LoanType], [NumberOfEMI], [MonthlyEMIAmount], [InterestRate], [DemandPromissoryNote], [PerquisiteRate], [LoanAccountNo], [PrincipalBalance], [InterestBalance], [Remarks], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (2, 6, N'1005', N'Vivek  Kulkarni', CAST(N'2021-12-10' AS Date), CAST(N'2021-12-24' AS Date), CAST(50000.00 AS Decimal(18, 2)), 0, CAST(N'2021-12-24' AS Date), 0, 26347249, CAST(300.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), 0, CAST(2.00 AS Decimal(18, 2)), N'5676586876', CAST(56554.00 AS Decimal(18, 2)), CAST(67.00 AS Decimal(18, 2)), N'ABC', 0, 1, NULL, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[LoanHeader] OFF
GO
SET IDENTITY_INSERT [dbo].[LookupDetailsM] ON 
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (1, 1, N'Male', N'Male', 1)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (2, 1, N'Female', N'Female', 1)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (3, 1, N'Male', N'Male', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (4, 1, N'Female', N'Female', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (5, 1, N'other', N'other', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (6, 5, N'01', N'January', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (7, 5, N'02', N'February', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (8, 5, N'3', N'March', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (9, 5, N'4', N'April', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (10, 5, N'5', N'May', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (11, 5, N'6', N'June', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (12, 5, N'7', N'July', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (13, 5, N'8', N'August', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (14, 5, N'9', N'September', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (15, 5, N'10', N'October', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (16, 5, N'11', N'November', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (17, 5, N'12', N'December', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (18, 6, N'ABC', N'ABC', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (1002, 1002, N'Earnings Component', N'AXG', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (1003, 1002, N'Joining Bonus', N'Joining Bonus', 0)
GO
INSERT [dbo].[LookupDetailsM] ([LookUpDetailsId], [LookUpId], [Name], [Description], [IsActive]) VALUES (1004, 1002, N'Other Allowance', N'Other Allowance', 0)
GO
SET IDENTITY_INSERT [dbo].[LookupDetailsM] OFF
GO
SET IDENTITY_INSERT [dbo].[LookupM] ON 
GO
INSERT [dbo].[LookupM] ([LookUpId], [LookUpCode], [LookUpName], [Description], [IsActive]) VALUES (1, N'E001', N'Gender', N'Gender', 0)
GO
INSERT [dbo].[LookupM] ([LookUpId], [LookUpCode], [LookUpName], [Description], [IsActive]) VALUES (2, N'E001', N'Designeation', N'Designeation', 1)
GO
INSERT [dbo].[LookupM] ([LookUpId], [LookUpCode], [LookUpName], [Description], [IsActive]) VALUES (3, N'E001', N'ABC', N'ABC', 1)
GO
INSERT [dbo].[LookupM] ([LookUpId], [LookUpCode], [LookUpName], [Description], [IsActive]) VALUES (4, N'E001', N'GenderAB', N'as', 1)
GO
INSERT [dbo].[LookupM] ([LookUpId], [LookUpCode], [LookUpName], [Description], [IsActive]) VALUES (5, N'M001', N'Month Name', N'Month Name', 0)
GO
INSERT [dbo].[LookupM] ([LookUpId], [LookUpCode], [LookUpName], [Description], [IsActive]) VALUES (6, N'L001', N'Loan Type', N'Loan Type', 0)
GO
INSERT [dbo].[LookupM] ([LookUpId], [LookUpCode], [LookUpName], [Description], [IsActive]) VALUES (1002, N'EC001', N'Earnings Components', N'Earnings Components', 0)
GO
SET IDENTITY_INSERT [dbo].[LookupM] OFF
GO
SET IDENTITY_INSERT [dbo].[MasterDataItems] ON 
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, 1, N'A+', N'A+', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, 1, N'A-', N'A-', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (3, 1, N'B+', N'B+', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (4, 1, N'B-', N'B-', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (5, 1, N'O+', N'O+', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (6, 1, N'O-', N'O-', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (7, 1, N'AB+', N'AB+', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (8, 1, N'AB-', N'AB-', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (9, 2, N'B.A.', N'B.A.', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (10, 2, N'BCA', N'BCA', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (11, 2, N'B.E.', N'B.E.', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (12, 2, N'B.Tech', N'B.Tech', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (13, 2, N'MBA', N'MBA', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (14, 2, N'MCA', N'MCA', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (15, 2, N'M.Tech', N'M.Tech', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (16, 2, N'Other', N'Other', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (17, 3, N'CERTIFICATION', N'CERTIFICATION', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (18, 3, N'DIPLOMA', N'DIPLOMA', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (19, 3, N'GRADUATE', N'GRADUATE', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (20, 3, N'HIGHER SECONDARY', N'HIGHER SECONDARY', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (21, 3, N'KEY SKILLS', N'KEY SKILLS', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (22, 3, N'POST GRADUATE', N'POST GRADUATE', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (23, 3, N'PRIMARY SKILLS', N'PRIMARY SKILLS', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (24, 6, N'Current', N'Current', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (25, 6, N'Fixed', N'Fixed', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (26, 6, N'Saving', N'Saving', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (27, 9, N'Accounts & Statutory', N' ACCOUNTS_STATUTORY', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (28, 9, N'Address', N'ADDRESS', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (29, 9, N'Previous Employment', N'PREV_EMP', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (30, 9, N'Qualification', N'QUAL', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (31, 10, N'Confirmed', N'Confirmed', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (32, 10, N'Probation', N'Probation', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (33, 11, N'Married', N'M', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (34, 11, N'Seperated', N'SE', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (35, 11, N'Single', N'S', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (36, 11, N'Widowed', N'W', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (37, 12, N'Indian', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (38, 12, N'Other', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (39, 13, N'Brother', N'BR', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (40, 13, N'Daughter', N'D', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (41, 13, N'Father', N'F', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (42, 13, N'Husband', N'H', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (43, 13, N'Mother', N'M', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (44, 13, N'Sister', N'SI', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (45, 13, N'Son', N'S', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (46, 13, N'Wife', N'W', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (47, 15, N'Access Card not available', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (48, 15, N'Domestic work', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (49, 15, N'Emergency', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (50, 15, N'Swipe not recognized', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (51, 16, N'Allowance or perquisites paid outside india for rendering service : Sec. 10(7)', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (52, 16, N'Allowance to meet expenditure incurred on house rent : Sec. 10(13A)', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (53, 16, N'Amount received on voluntary retirement or termination of service : Sec. 10(10C)', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (54, 16, N'Books And Periodicals Exemption', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (55, 16, N'Children Education Exemption', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (56, 16, N'Driver Exemption', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (57, 16, N'Food Exemption', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (58, 16, N'Internet Exemption', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (59, 16, N'Prescribed Allowance granted to meet expenses wholly necessarily & exclusively : Sec. 10(14)(i)', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (60, 16, N'Prescribed Allowance granted to meet personal expenses : Sec. 10(14)(ii)', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (61, 16, N'Remuneration received an official : Sec. 10(6)', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (62, 16, N'Tax paid by employer on non-monetary perquisite : Sec. 10(10CC)', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (63, 16, N'Telephone Exemption', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (64, 16, N'Vehicle Exemption', NULL, 1, N'22-11-2020', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (65, 17, N'YearlyOpeningBalance', N'Yearly Opening Balance', 1, N'10-02-2021', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (66, 18, N'Finance', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (68, 18, N'GSI', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (69, 18, N'HR', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (70, 18, N'IT', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (71, 18, N'KB TCI-IT', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (72, 18, N'PURCHASE', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (73, 18, N'Quality', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (74, 18, N'RAIL', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (75, 18, N'TRUCK', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (76, 19, N'MERAK SW', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (77, 19, N'NYAB', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (78, 19, N'Selectron', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (79, 19, N'TR0161', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (80, 19, N'TR0200', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (81, 19, N'TR0201', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (82, 19, N'TR0203', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (83, 19, N'TR0209', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (84, 19, N'TR0210', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (85, 19, N'TR0215', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (86, 20, N'4(4A) I', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (87, 20, N'L4(4B) I', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (88, 20, N'L4(4B) II', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (89, 20, N'L5 (5A) I', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (90, 20, N'L5(5A) I', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (91, 20, N'L5(5A) II', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (92, 20, N'L5(5B) I', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (93, 20, N'L5 (5B) II', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (94, 20, N'L5(5B) II', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (95, 20, N'L5 (5B) III', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (96, 20, N'L5(5B) III', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (97, 20, N'L6 (6A) I', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (98, 20, N'L6(6B) I', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (99, 20, N'L6 (6A) II', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (100, 20, N'L6 (6B) II', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (101, 20, N'L6 (6A) III', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (102, 20, N'L6 (6B) III', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (103, 20, N'L7(7A) I', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (104, 20, N'L7 (C)', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (105, 20, N'NA', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (106, 21, N'External', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (107, 21, N'I', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (108, 21, N'II', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (109, 21, N'III', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (110, 21, N'NA', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (111, 22, N'External', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (112, 22, N'L3', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (113, 22, N'L4', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (114, 22, N'L5', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (115, 22, N'L6', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (116, 22, N'L7', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (117, 22, N'NA', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (118, 23, N'(4A)', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (119, 23, N'(4B)', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (120, 23, N'5A', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (121, 23, N'(5A)', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (122, 23, N'5B', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (123, 23, N'(5B)', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (124, 23, N'6A', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (125, 23, N'(6A)', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (126, 23, N'6B', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (127, 23, N'(6B)', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (128, 23, N'(7A)', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (129, 23, N'(C)', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (130, 23, N'External', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (131, 23, N'NA', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (132, 24, N'Bangalore', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (133, 24, N'Chennai', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (134, 24, N'Cochin', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (135, 24, N'Delhi', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (136, 24, N'Hyderabad', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (137, 24, N'Mangalore', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (138, 24, N'Mumbai', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (139, 24, N'Pune', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (140, 24, N'Tirupati', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (141, 24, N'Vijayawada', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (142, 25, N'Entrpreneurship', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (143, 25, N'Passion', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (144, 25, N'Reliability', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (145, 25, N'Responsibility', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (146, 25, N'Technological Excellence', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (147, 26, N'Cash', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (148, 26, N'Bank Transfer', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (149, 26, N'Cheque', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (150, 26, N'Demand Draft', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (151, 27, N'Admin', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (152, 27, N'Administration & HSE', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (153, 27, N'Central Function', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (154, 27, N'Corporate IT Support Center', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (155, 27, N'Finance', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (156, 27, N'HR & Admin', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (157, 27, N'IT', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (158, 27, N'Management', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (159, 27, N'Purchase', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (160, 27, N'Quality', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (161, 27, N'RD1', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (162, 27, N'RD2', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (163, 27, N'RD3', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (164, 27, N'RD4', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (165, 27, N'RD5', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (166, 28, N'Assistant Manager', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (167, 28, N'Associate', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (168, 28, N'Component Engineer', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (169, 28, N'Embedded Developer(EXT)', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (170, 28, N'Director', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (171, 28, N'Executive', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (172, 28, N'General Manager', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (173, 28, N'Management', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (174, 28, N'Head of Department', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (175, 28, N'HR Associate', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (176, 28, N'Intern', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (177, 28, N'Manager', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (178, 28, N'Managing Director', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (179, 28, N'Project Leader', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (180, 28, N'Project Manager', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (181, 28, N'Senior Engineer', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (182, 28, N'Senior Manager', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (183, 28, N'Senior Project Leader', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (184, 28, N'Senior Project Manager', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (185, 28, N'Senior Technician', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (186, 28, N'Software Engineer(EXT)', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (187, 28, N'Technical Specialist', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (188, 28, N'Quality Inspector', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (189, 28, N'Engineering Support Associate', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (190, 28, N'Trainee Engineer', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (191, 14, N'Hindu', N'Hindu Religion', 1, N'26-07-2021', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (192, 14, N'Muslim', N'Muslim Religion', 1, N'26-07-2021', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (193, 14, N'Sikh', N'Muslim Religion', 1, N'26-07-2021', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (194, 14, N'Christian', N'Christian Religion', 1, N'26-07-2021', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (195, 14, N'Others', N'Other Religions', 1, N'26-07-2021', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (196, 29, N'Male', N'Male Gender', 1, N'26-07-2021', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (197, 29, N'Female', N'Female Gender', 1, N'26-07-2021', 1)
GO
INSERT [dbo].[MasterDataItems] ([MasterDataItemId], [ItemTypeId], [MasterDataItemValue], [ItemDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (198, 29, N'Other', N'Other Genders', 1, N'26-07-2021', 1)
GO
SET IDENTITY_INSERT [dbo].[MasterDataItems] OFF
GO
SET IDENTITY_INSERT [dbo].[MasterDataItemTypes] ON 
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, N'BloodGroup', N'BloodGroup', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, N'Qualification', N'Qualification', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (3, N'QualificationLevel', N'QualificationLevel', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (4, N'Bank', N'Bank', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (5, N'BankBranch', N'BankBranch', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (6, N'BankAccountType', N'BankAccountType', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (7, N'Country', N'Country', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (8, N'Currency', N'Currency', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (9, N'EmployeeDocumentCategory', N'EmployeeDocumentCategory', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (10, N'EmployeeStatus', N'EmployeeStatus', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (11, N'MaritalStatus', N'MaritalStatus', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (12, N'Nationality', N'Nationality', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (13, N'Relation', N'Relation', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (14, N'Religion', N'Religion', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (15, N'AttandanceRegularizationReason', N'AttandanceRegularizationReason', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (16, N'ExemptionGroup', N'ExemptionGroup', 1, N'21-11-2020', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (17, N'LeaveGeneralSettings', N'LeaveGeneralSettings', 1, N'10-02-2021', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (18, N'Division', N'Division', 1, N'10-02-2021', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (19, N'CostCenter', N'Cost Center', 1, N'10-02-2021', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (20, N'Grade', N'Grade', 1, N'10-02-2021', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (21, N'FunctionalGrade', N'Functional Grade', 1, N'10-02-2021', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (22, N'Level', N'Level', 1, N'10-02-2021', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (23, N'SubLevel', N'Sub Level', 1, N'10-02-2021', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (24, N'Location', N'Location', 1, N'10-02-2021', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (25, N'HouseName', N'House Name', 1, N'10-02-2021', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (26, N'PaymentMode', N'Payment Mode', 1, N'10-02-2021', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (27, N'Department', N'Department', 1, N'10-02-2021', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (28, N'Designation', N'Designation', 1, N'10-02-2021', 1)
GO
INSERT [dbo].[MasterDataItemTypes] ([ItemTypeId], [ItemTypeName], [Description], [IsActive], [CreatedDate], [CreatedBy]) VALUES (29, N'Gender', N'Gender of Employee', 1, N'26-07-2021', 1)
GO
SET IDENTITY_INSERT [dbo].[MasterDataItemTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[PageAccessSetup] ON 
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (1, 2, 1, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (2, 2, 2, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (3, 2, 3, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (4, 2, 4, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (5, 2, 5, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (6, 2, 6, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (7, 2, 7, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (8, 2, 8, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (9, 2, 9, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (10, 2, 10, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (11, 2, 11, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (12, 2, 12, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (13, 2, 13, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (14, 2, 14, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (15, 2, 15, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (16, 2, 16, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (17, 2, 17, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (18, 2, 18, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (19, 4, 1, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (20, 4, 2, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (21, 4, 3, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (22, 4, 4, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (23, 4, 5, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (24, 4, 6, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (27, 4, 7, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (28, 4, 8, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (29, 4, 9, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (30, 4, 10, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (31, 4, 11, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (32, 4, 12, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (33, 4, 13, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (34, 4, 14, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (35, 4, 15, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (36, 4, 16, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (37, 4, 17, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (38, 4, 18, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (39, 2, 19, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (40, 2, 20, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (41, 4, 19, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (42, 4, 20, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (43, 6, 1, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (44, 6, 2, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (45, 6, 3, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (46, 6, 4, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (47, 6, 5, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (48, 6, 6, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (49, 6, 7, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (50, 6, 8, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (51, 6, 9, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (52, 6, 10, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (53, 6, 11, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (54, 6, 12, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (55, 6, 13, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (56, 6, 14, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (57, 6, 15, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (58, 6, 16, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (59, 6, 17, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (60, 6, 18, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (61, 6, 19, 1, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (62, 6, 20, 0, N'30-12-2020', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (63, 1, 1, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (64, 1, 2, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (65, 1, 3, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (66, 1, 4, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (67, 1, 5, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (68, 1, 6, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (69, 1, 7, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (70, 1, 8, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (71, 1, 9, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (72, 1, 10, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (73, 1, 11, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (74, 1, 12, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (75, 1, 13, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (76, 1, 14, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (77, 1, 15, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (78, 1, 16, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (79, 1, 17, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (80, 1, 18, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (81, 1, 19, 1, N'24-06-2021', 1)
GO
INSERT [dbo].[PageAccessSetup] ([PageAccessId], [RoleId], [PageModuleId], [IsAllow], [ModifiedDate], [ModifiedBy]) VALUES (82, 1, 20, 1, N'24-06-2021', 1)
GO
SET IDENTITY_INSERT [dbo].[PageAccessSetup] OFF
GO
SET IDENTITY_INSERT [dbo].[PageModules] ON 
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (1, N'AddEmployee')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (2, N'EmployeeList')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (3, N'GeneralSettings')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (4, N'LeaveTypes')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (5, N'LeaveRules')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (6, N'LeavePolicySetup')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (7, N'Notifications')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (8, N'LeaveReasons')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (9, N'LeaveReports')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (10, N'Shifts')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (11, N'AttendancePolicySetup')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (12, N'AttendanceScheme')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (13, N'ShowLeaves')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (14, N'ApplyLeave')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (15, N'ShowAttendance')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (16, N'HelpDeskSetup')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (17, N'HelpDeskAnalysis')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (18, N'ReportsMapping')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (19, N'Dashboard')
GO
INSERT [dbo].[PageModules] ([PageModuleId], [PageModuleName]) VALUES (20, N'ESSDashboard')
GO
SET IDENTITY_INSERT [dbo].[PageModules] OFF
GO
INSERT [dbo].[Presence] ([PresenceId], [PresenceName], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (N'h', N'H(Holiday,Weekend)', 1, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Presence] ([PresenceId], [PresenceName], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (N'v', N'V(Leave,Vacation)', 1, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Presence] ([PresenceId], [PresenceName], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (N'w', N'W(Irregular Working Day)', 1, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Presence] ([PresenceId], [PresenceName], [IsActive], [CreatedDate], [CreatedBy], [DateOfResignation], [DateOfLastWorking]) VALUES (N'x', N'X(Invalid, Not Applicable Day)', 1, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[PrevEmploymentDetails] ON 
GO
INSERT [dbo].[PrevEmploymentDetails] ([PrevEmploymentDetailsId], [PrevEmployeeId], [PrevEmploymentOrder], [PrevEmploymentName], [PrevCompanyAddress], [Designation], [JoinedDate], [LeavingDate], [LeavingReason], [ContactPerson1], [ContactPerson1No], [ContactPerson2], [ContactPerson2No], [ContactPerson3], [ContactPerson3No], [VerificationStatus], [VerifiedDate], [VerifiedBy], [VerificationComments], [CreatedDate], [CreatedBy]) VALUES (2, 1, 1, N'Opus Solutions', N'Yerwada, Pune, Maharashtra, India', N'Delivery Head', N'01-08-2016', N'30-09-2017', N'Better Prospects', N'Contact1', N'8983034999', N'Contact2', N'8983034999', N'Contact3', N'8983034999', NULL, NULL, NULL, NULL, N'23-08-2021', 1)
GO
INSERT [dbo].[PrevEmploymentDetails] ([PrevEmploymentDetailsId], [PrevEmployeeId], [PrevEmploymentOrder], [PrevEmploymentName], [PrevCompanyAddress], [Designation], [JoinedDate], [LeavingDate], [LeavingReason], [ContactPerson1], [ContactPerson1No], [ContactPerson2], [ContactPerson2No], [ContactPerson3], [ContactPerson3No], [VerificationStatus], [VerifiedDate], [VerifiedBy], [VerificationComments], [CreatedDate], [CreatedBy]) VALUES (3, 1, 2, N'Wipro Technologies', N'Hinjewadi, Pune', N'Project Manager', N'01-01-2006', N'30-09-2008', N'Better Prospects', N'Contact1', N'9890044879', N'Contact2', N'9890044870', N'Contact3', N'9890044878', NULL, NULL, NULL, NULL, N'23-08-2021', 1)
GO
INSERT [dbo].[PrevEmploymentDetails] ([PrevEmploymentDetailsId], [PrevEmployeeId], [PrevEmploymentOrder], [PrevEmploymentName], [PrevCompanyAddress], [Designation], [JoinedDate], [LeavingDate], [LeavingReason], [ContactPerson1], [ContactPerson1No], [ContactPerson2], [ContactPerson2No], [ContactPerson3], [ContactPerson3No], [VerificationStatus], [VerifiedDate], [VerifiedBy], [VerificationComments], [CreatedDate], [CreatedBy]) VALUES (4, 1, 3, N'Syntel Inc', N'Talawade, Pune', N'Project Manager', N'06-06-2008', N'12-06-2009', N'Job Loss', N'Contact1', N'9890044879', N'Contact2', N'9890044878', N'Contact3', N'9890044877', NULL, NULL, NULL, NULL, N'23-08-2021', 1)
GO
SET IDENTITY_INSERT [dbo].[PrevEmploymentDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchaseModuleScheme] ON 
GO
INSERT [dbo].[PurchaseModuleScheme] ([PurchaseModuleSchemeId], [PurchaseModuleName], [PurchaseModuleCode], [Description], [CreatedDate], [Createdby]) VALUES (1, N'Employee Muster', N'EMP', N'Employee Muster', N'20-11-2020', 1)
GO
INSERT [dbo].[PurchaseModuleScheme] ([PurchaseModuleSchemeId], [PurchaseModuleName], [PurchaseModuleCode], [Description], [CreatedDate], [Createdby]) VALUES (2, N'Empoyee and Leave', N'EL', N'Empoyee and Leave', N'20-11-2020', 1)
GO
INSERT [dbo].[PurchaseModuleScheme] ([PurchaseModuleSchemeId], [PurchaseModuleName], [PurchaseModuleCode], [Description], [CreatedDate], [Createdby]) VALUES (3, N'Leave and Attendance', N'LA', N'Leave and Attendance', N'20-11-2020', 1)
GO
INSERT [dbo].[PurchaseModuleScheme] ([PurchaseModuleSchemeId], [PurchaseModuleName], [PurchaseModuleCode], [Description], [CreatedDate], [Createdby]) VALUES (4, N'Leave Attendance and Payroll', N'LAP', N'Leave Attendance and Payroll', N'20-11-2020', 1)
GO
INSERT [dbo].[PurchaseModuleScheme] ([PurchaseModuleSchemeId], [PurchaseModuleName], [PurchaseModuleCode], [Description], [CreatedDate], [Createdby]) VALUES (5, N'Payroll', N'P', N'Payroll', N'20-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[PurchaseModuleScheme] OFF
GO
SET IDENTITY_INSERT [dbo].[RoleMaster] ON 
GO
INSERT [dbo].[RoleMaster] ([RoleId], [RoleName], [RoleDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, N'SAdmin', N'SAdmin', 1, N'15-12-2020', 1)
GO
INSERT [dbo].[RoleMaster] ([RoleId], [RoleName], [RoleDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, N'CAdmin', N'CAdmin', 1, N'15-12-2020', 1)
GO
INSERT [dbo].[RoleMaster] ([RoleId], [RoleName], [RoleDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (3, N'DemoUser', N'DemoUser', 1, N'15-12-2020', 1)
GO
INSERT [dbo].[RoleMaster] ([RoleId], [RoleName], [RoleDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (4, N'EmpUser', N'EmployeeUser', 1, N'15-12-2020', 1)
GO
INSERT [dbo].[RoleMaster] ([RoleId], [RoleName], [RoleDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (5, N'RestrictedUser', N'RestrictedUser', 1, N'15-12-2020', 1)
GO
INSERT [dbo].[RoleMaster] ([RoleId], [RoleName], [RoleDescription], [IsActive], [CreatedDate], [CreatedBy]) VALUES (6, N'ReportingManager', N'ReportingManager', 1, N'05-01-2021', 1)
GO
SET IDENTITY_INSERT [dbo].[RoleMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[SalaryDetails] ON 
GO
INSERT [dbo].[SalaryDetails] ([ID], [HeaderID], [Basic], [HRA], [Bonus], [OtherAllowance], [Overttime], [ProfTax], [Loan], [AdvanceSalary], [EmployeeContributionPF], [EmployeeContributionESIC], [EmployerContributionPF], [EmployerContributionESIC], [MonthlyNetPay], [MonthlyGrossPay], [AnnualGrossSalary], [AnnualGrossCTC], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (1, 1, CAST(34100.00 AS Decimal(18, 2)), CAST(13640.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(20460.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(200.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(66200.00 AS Decimal(18, 2)), CAST(68200.00 AS Decimal(18, 2)), CAST(818400.00 AS Decimal(18, 2)), CAST(840000.00 AS Decimal(18, 2)), 1, NULL, NULL, 0, NULL)
GO
INSERT [dbo].[SalaryDetails] ([ID], [HeaderID], [Basic], [HRA], [Bonus], [OtherAllowance], [Overttime], [ProfTax], [Loan], [AdvanceSalary], [EmployeeContributionPF], [EmployeeContributionESIC], [EmployerContributionPF], [EmployerContributionESIC], [MonthlyNetPay], [MonthlyGrossPay], [AnnualGrossSalary], [AnnualGrossCTC], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (2, 2, CAST(24100.00 AS Decimal(18, 2)), CAST(9640.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(14460.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(200.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(46200.00 AS Decimal(18, 2)), CAST(48200.00 AS Decimal(18, 2)), CAST(578400.00 AS Decimal(18, 2)), CAST(600000.00 AS Decimal(18, 2)), 1, NULL, NULL, 0, NULL)
GO
INSERT [dbo].[SalaryDetails] ([ID], [HeaderID], [Basic], [HRA], [Bonus], [OtherAllowance], [Overttime], [ProfTax], [Loan], [AdvanceSalary], [EmployeeContributionPF], [EmployeeContributionESIC], [EmployerContributionPF], [EmployerContributionESIC], [MonthlyNetPay], [MonthlyGrossPay], [AnnualGrossSalary], [AnnualGrossCTC], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (3, 3, CAST(10000.00 AS Decimal(18, 2)), CAST(4000.00 AS Decimal(18, 2)), CAST(833.00 AS Decimal(18, 2)), CAST(5167.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(200.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1200.00 AS Decimal(18, 2)), CAST(150.00 AS Decimal(18, 2)), CAST(1200.00 AS Decimal(18, 2)), CAST(650.00 AS Decimal(18, 2)), CAST(18450.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), CAST(240000.00 AS Decimal(18, 2)), CAST(262200.00 AS Decimal(18, 2)), 1, NULL, NULL, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[SalaryDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[SalaryHeader] ON 
GO
INSERT [dbo].[SalaryHeader] ([ID], [EmployeeID], [EmployeeNumber], [EmployeeName], [EmployeeType], [Gender], [PFAvailability], [DOJ], [DOB], [LastPayrollProceesedDate], [Location], [PayoutMonth], [Remarks], [EffectiveStartDate], [EffectiveEndDate], [Status], [VersionNumber], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (1, 1035, N'4', N'GHI XYZ', 0, 0, 0, CAST(N'2020-08-04' AS Date), CAST(N'1987-06-10' AS Date), CAST(N'2022-01-01T00:00:00.000' AS DateTime), NULL, 1, N'', CAST(N'2022-01-01' AS Date), CAST(N'2025-12-31' AS Date), N'Approved', 1, 1, NULL, NULL, 0, NULL)
GO
INSERT [dbo].[SalaryHeader] ([ID], [EmployeeID], [EmployeeNumber], [EmployeeName], [EmployeeType], [Gender], [PFAvailability], [DOJ], [DOB], [LastPayrollProceesedDate], [Location], [PayoutMonth], [Remarks], [EffectiveStartDate], [EffectiveEndDate], [Status], [VersionNumber], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (2, 1036, N'5', N'KLM AVC', 0, 0, 0, CAST(N'2021-04-23' AS Date), CAST(N'1987-06-10' AS Date), CAST(N'2022-01-01T00:00:00.000' AS DateTime), NULL, 1, N'', CAST(N'2022-01-01' AS Date), CAST(N'2025-12-31' AS Date), N'Approved', 1, 1, NULL, NULL, 0, NULL)
GO
INSERT [dbo].[SalaryHeader] ([ID], [EmployeeID], [EmployeeNumber], [EmployeeName], [EmployeeType], [Gender], [PFAvailability], [DOJ], [DOB], [LastPayrollProceesedDate], [Location], [PayoutMonth], [Remarks], [EffectiveStartDate], [EffectiveEndDate], [Status], [VersionNumber], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (3, 1037, N'6', N'OPQ HJY', 0, 0, 0, CAST(N'2021-12-15' AS Date), CAST(N'1987-06-10' AS Date), CAST(N'2022-01-01T00:00:00.000' AS DateTime), NULL, 1, N'', CAST(N'2022-01-01' AS Date), CAST(N'2025-12-31' AS Date), N'Approved', 1, 1, NULL, NULL, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[SalaryHeader] OFF
GO
SET IDENTITY_INSERT [dbo].[SalaryMonthlyStatement] ON 
GO
INSERT [dbo].[SalaryMonthlyStatement] ([ID], [SalaryDetailsId], [EmployeeID], [EmployeeNumber], [EmployeeName], [DOJ], [DaysInMonth], [LOPDays], [TotalWorkingDays], [PayoutMonthInNo], [PayoutYR], [PayoutMonth], [VersionNumber], [EarningsComponentsAmt], [DeductionComponentsAmt], [Basic], [HRA], [Bonus], [OtherAllowance], [Overttime], [ProfTax], [Arrears], [Reimbursement], [Loan], [AdvanceSalary], [MonthlyPF], [MonthlyESIC], [MonthlyNetPay], [MonthlyGrossPay], [TotalDeduction], [NetPay], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [MailSendStatus]) VALUES (1, 1, 1035, N'4', N'GHI XYZ', CAST(N'2020-08-04' AS Date), N'31', N'2.00', N'29.00', 1, 2022, N'January', 1, CAST(20000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(31900.00 AS Decimal(18, 2)), CAST(12760.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(19140.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(200.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(83800.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)), CAST(81800.00 AS Decimal(18, 2)), 1, NULL, CAST(N'2022-03-04T19:58:24.593' AS DateTime), NULL, NULL, N'Pending')
GO
INSERT [dbo].[SalaryMonthlyStatement] ([ID], [SalaryDetailsId], [EmployeeID], [EmployeeNumber], [EmployeeName], [DOJ], [DaysInMonth], [LOPDays], [TotalWorkingDays], [PayoutMonthInNo], [PayoutYR], [PayoutMonth], [VersionNumber], [EarningsComponentsAmt], [DeductionComponentsAmt], [Basic], [HRA], [Bonus], [OtherAllowance], [Overttime], [ProfTax], [Arrears], [Reimbursement], [Loan], [AdvanceSalary], [MonthlyPF], [MonthlyESIC], [MonthlyNetPay], [MonthlyGrossPay], [TotalDeduction], [NetPay], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [MailSendStatus]) VALUES (2, 2, 1036, N'5', N'KLM AVC', CAST(N'2021-04-23' AS Date), N'31', N'0.00', N'31.00', 1, 2022, N'January', 1, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(24100.00 AS Decimal(18, 2)), CAST(9640.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(14460.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(200.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(48200.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)), CAST(46200.00 AS Decimal(18, 2)), 1, NULL, CAST(N'2022-03-04T19:58:24.670' AS DateTime), NULL, NULL, N'Pending')
GO
INSERT [dbo].[SalaryMonthlyStatement] ([ID], [SalaryDetailsId], [EmployeeID], [EmployeeNumber], [EmployeeName], [DOJ], [DaysInMonth], [LOPDays], [TotalWorkingDays], [PayoutMonthInNo], [PayoutYR], [PayoutMonth], [VersionNumber], [EarningsComponentsAmt], [DeductionComponentsAmt], [Basic], [HRA], [Bonus], [OtherAllowance], [Overttime], [ProfTax], [Arrears], [Reimbursement], [Loan], [AdvanceSalary], [MonthlyPF], [MonthlyESIC], [MonthlyNetPay], [MonthlyGrossPay], [TotalDeduction], [NetPay], [IsActive], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [MailSendStatus]) VALUES (3, 3, 1037, N'6', N'OPQ HJY', CAST(N'2021-12-15' AS Date), N'31', N'2.50', N'26.50', 1, 2022, N'January', 1, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(8548.00 AS Decimal(18, 2)), CAST(3419.00 AS Decimal(18, 2)), CAST(712.00 AS Decimal(18, 2)), CAST(4417.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(200.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1026.00 AS Decimal(18, 2)), CAST(128.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(17097.00 AS Decimal(18, 2)), CAST(1354.00 AS Decimal(18, 2)), CAST(15743.00 AS Decimal(18, 2)), 1, NULL, CAST(N'2022-03-04T19:58:24.677' AS DateTime), NULL, NULL, N'Pending')
GO
SET IDENTITY_INSERT [dbo].[SalaryMonthlyStatement] OFF
GO
SET IDENTITY_INSERT [dbo].[SettingsDataItems] ON 
GO
INSERT [dbo].[SettingsDataItems] ([SettingsDataItemId], [SettingsItemTypeId], [SettingsDataItemName], [SettingsDataItemValue], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, 1, N'YearlyOpeningBalance', N'', 1, N'10-02-2021', 1)
GO
INSERT [dbo].[SettingsDataItems] ([SettingsDataItemId], [SettingsItemTypeId], [SettingsDataItemName], [SettingsDataItemValue], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, 1, N'LeavePolicyYear', N'', 1, N'10-02-2021', 1)
GO
SET IDENTITY_INSERT [dbo].[SettingsDataItems] OFF
GO
SET IDENTITY_INSERT [dbo].[SettingsDataItemTypes] ON 
GO
INSERT [dbo].[SettingsDataItemTypes] ([SettingsItemTypeId], [SettingsItemTypeName], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, N'LeaveGeneralSettings', 1, N'10-02-2021', 1)
GO
SET IDENTITY_INSERT [dbo].[SettingsDataItemTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Shift] ON 
GO
INSERT [dbo].[Shift] ([ShiftId], [ShiftName], [ShiftCode], [HalfDayMinimumHours], [FullDayMinimumHours], [CalculateShiftHoursBasedOnScheme], [CreatedDate], [CreatedBy]) VALUES (1, N'General Shift', N'GN', N'04:00', N'09:00', 1, N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[Shift] OFF
GO
SET IDENTITY_INSERT [dbo].[ShiftHoursCalculationScheme] ON 
GO
INSERT [dbo].[ShiftHoursCalculationScheme] ([ShiftHoursCalculationSchemeId], [ShiftHoursCalculationSchemeName], [IsActive], [CreatedDate], [Createdby]) VALUES (1, N'Sum of Session''s In and Out time for a day.', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[ShiftHoursCalculationScheme] ([ShiftHoursCalculationSchemeId], [ShiftHoursCalculationSchemeName], [IsActive], [CreatedDate], [Createdby]) VALUES (2, N'Shift Start Time and End Time for a day.', 1, N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[ShiftHoursCalculationScheme] OFF
GO
SET IDENTITY_INSERT [dbo].[ShiftSessions] ON 
GO
INSERT [dbo].[ShiftSessions] ([ShiftSessionId], [ShiftSessionName], [Description], [ShiftId], [InTime], [OutTime], [GraceInTime], [GraceOutTime], [InMarginTime], [OutMarginTime], [IsActive], [CreatedDate], [CreatedBy]) VALUES (1, N'Session1', N'First Session', 1, N'09:00', N'13:00', N'00:30', N'00:00', N'03:00', N'00:30', 1, N'22-11-2020', 1)
GO
INSERT [dbo].[ShiftSessions] ([ShiftSessionId], [ShiftSessionName], [Description], [ShiftId], [InTime], [OutTime], [GraceInTime], [GraceOutTime], [InMarginTime], [OutMarginTime], [IsActive], [CreatedDate], [CreatedBy]) VALUES (2, N'Session2', N'Second Session', 1, N'13:30', N'18:00', N'00:00', N'00:00', N'00:00', N'11:59', 1, N'22-11-2020', 1)
GO
SET IDENTITY_INSERT [dbo].[ShiftSessions] OFF
GO
SET IDENTITY_INSERT [dbo].[TaxLocationProfTaxMapping] ON 
GO
INSERT [dbo].[TaxLocationProfTaxMapping] ([ID], [LocationID], [ProfTax]) VALUES (1, 132, CAST(200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[TaxLocationProfTaxMapping] ([ID], [LocationID], [ProfTax]) VALUES (2, 135, CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[TaxLocationProfTaxMapping] ([ID], [LocationID], [ProfTax]) VALUES (3, 139, CAST(200.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[TaxLocationProfTaxMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[TimeRecordingSheetDetails] ON 
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1, 6, CAST(N'2022-01-01T00:00:00.000' AS DateTime), N'Saturday', 1, 1, N'09:30', N'18:30', N'09:00', N'00:30', N'08:30', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (2, 6, CAST(N'2022-01-02T00:00:00.000' AS DateTime), N'Sunday', 1, 2, N'08:00', N'19:20', N'11:20', N'01:00', N'10:20', N'v', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (3, 6, CAST(N'2022-01-03T00:00:00.000' AS DateTime), N'Monday', 1, 3, N'10:00', N'17:00', N'07:00', N'00:30', N'06:30', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (4, 6, CAST(N'2022-01-04T00:00:00.000' AS DateTime), N'Tuesday', 1, 4, N'08:00', N'16:30', N'08:30', N'00:20', N'08:10', N'x', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (5, 6, CAST(N'2022-01-05T00:00:00.000' AS DateTime), N'Wednesday', 1, 5, N'07:00', N'18:40', N'11:40', N'00:40', N'11:00', N'x', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (6, 6, CAST(N'2022-01-06T00:00:00.000' AS DateTime), N'Thursday', 1, 6, N'08:30', N'19:20', N'10:50', N'01:00', N'09:50', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (7, 6, CAST(N'2022-01-07T00:00:00.000' AS DateTime), N'Friday', 1, 7, N'07:13', N'19:12', N'11:59', N'01:00', N'10:59', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (8, 6, CAST(N'2022-01-10T00:00:00.000' AS DateTime), N'Monday', 1, 10, N'08:00', N'19:22', N'11:22', N'03:00', N'08:22', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (9, 6, CAST(N'2022-01-11T00:00:00.000' AS DateTime), N'Tuesday', 1, 11, N'09:00', N'14:00', N'05:00', N'00:30', N'04:30', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (10, 6, CAST(N'2022-01-12T00:00:00.000' AS DateTime), N'Wednesday', 1, 12, N'08:00', N'15:59', N'07:59', N'01:00', N'06:59', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (11, 6, CAST(N'2022-01-13T00:00:00.000' AS DateTime), N'Thursday', 1, 13, N'07:30', N'18:59', N'11:29', N'03:00', N'08:29', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (12, 6, CAST(N'2022-01-17T00:00:00.000' AS DateTime), N'Monday', 1, 17, N'08:00', N'19:00', N'11:00', N'00:30', N'10:30', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (13, 6, CAST(N'2022-01-18T00:00:00.000' AS DateTime), N'Tuesday', 1, 18, N'08:29', N'17:00', N'08:31', N'00:15', N'08:16', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (14, 6, CAST(N'2022-01-19T00:00:00.000' AS DateTime), N'Wednesday', 1, 19, N'07:45', N'17:06', N'09:21', N'02:00', N'07:21', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (15, 6, CAST(N'2022-01-20T00:00:00.000' AS DateTime), N'Thursday', 1, 20, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (16, 6, CAST(N'2022-01-21T00:00:00.000' AS DateTime), N'Friday', 1, 21, N'07:00', N'18:00', N'11:00', N'02:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (17, 6, CAST(N'2022-01-24T00:00:00.000' AS DateTime), N'Monday', 1, 24, N'09:00', N'19:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (18, 6, CAST(N'2022-01-25T00:00:00.000' AS DateTime), N'Tuesday', 1, 25, N'09:00', N'18:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (19, 6, CAST(N'2022-01-26T00:00:00.000' AS DateTime), N'Wednesday', 1, 26, N'09:00', N'18:00', N'09:00', N'01:00', N'08:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (20, 6, CAST(N'2022-01-27T00:00:00.000' AS DateTime), N'Thursday', 1, 27, N'09:00', N'18:00', N'09:00', N'01:00', N'08:00', N'v', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (21, 6, CAST(N'2022-01-28T00:00:00.000' AS DateTime), N'Friday', 1, 28, N'09:00', N'18:00', N'09:00', N'00:30', N'08:30', N'x', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (22, 6, CAST(N'2022-01-31T00:00:00.000' AS DateTime), N'Monday', 1, 31, N'09:30', N'18:30', N'09:00', N'00:30', N'08:30', N'x', NULL, 1, 0, 0)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (27, 13, CAST(N'2022-01-03T00:00:00.000' AS DateTime), N'Monday', 1, 3, N'09:00', N'17:00', N'08:00', N'01:00', N'07:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (28, 13, CAST(N'2022-01-04T00:00:00.000' AS DateTime), N'Tuesday', 1, 4, N'09:30', N'18:00', N'08:30', N'03:00', N'05:30', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (29, 13, CAST(N'2022-01-05T00:00:00.000' AS DateTime), N'Wednesday', 1, 5, N'08:30', N'17:00', N'08:30', N'00:30', N'08:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (30, 13, CAST(N'2022-01-06T00:00:00.000' AS DateTime), N'Thursday', 1, 6, N'09:00', N'19:00', N'10:00', N'01:00', N'09:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (31, 13, CAST(N'2022-01-07T00:00:00.000' AS DateTime), N'Friday', 1, 7, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (32, 13, CAST(N'2022-01-10T00:00:00.000' AS DateTime), N'Monday', 1, 10, N'09:00', N'17:00', N'08:00', N'00:00', N'08:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (33, 13, CAST(N'2022-01-11T00:00:00.000' AS DateTime), N'Tuesday', 1, 11, N'09:00', N'18:00', N'09:00', N'01:00', N'08:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (34, 13, CAST(N'2022-01-12T00:00:00.000' AS DateTime), N'Wednesday', 1, 12, N'08:00', N'18:00', N'10:00', N'00:30', N'09:30', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (35, 13, CAST(N'2022-01-13T00:00:00.000' AS DateTime), N'Thursday', 1, 13, N'09:00', N'18:00', N'09:00', N'00:30', N'08:30', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (37, 13, CAST(N'2022-01-14T00:00:00.000' AS DateTime), N'Friday', 1, 14, N'08:00', N'18:00', N'10:00', N'00:30', N'09:30', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (38, 13, CAST(N'2022-01-17T00:00:00.000' AS DateTime), N'Monday', 1, 17, N'09:00', N'16:00', N'07:00', N'00:30', N'06:30', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (39, 13, CAST(N'2022-01-18T00:00:00.000' AS DateTime), N'Tuesday', 1, 18, N'08:00', N'19:00', N'11:00', N'02:00', N'09:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (40, 13, CAST(N'2022-01-24T00:00:00.000' AS DateTime), N'Monday', 1, 24, N'09:00', N'18:00', N'09:00', N'01:00', N'08:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (41, 13, CAST(N'2022-01-25T00:00:00.000' AS DateTime), N'Tuesday', 1, 25, N'14:00', N'22:00', N'08:00', N'02:00', N'06:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (42, 13, CAST(N'2022-01-26T00:00:00.000' AS DateTime), N'Wednesday', 1, 26, N'09:00', N'18:00', N'09:00', N'03:00', N'06:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (43, 13, CAST(N'2022-01-27T00:00:00.000' AS DateTime), N'Thursday', 1, 27, N'09:00', N'18:00', N'09:00', N'01:00', N'08:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (44, 13, CAST(N'2022-01-28T00:00:00.000' AS DateTime), N'Friday', 1, 28, N'08:00', N'19:00', N'11:00', N'02:00', N'09:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (45, 13, CAST(N'2022-01-31T00:00:00.000' AS DateTime), N'Monday', 1, 31, N'08:30', N'18:00', N'09:30', N'01:00', N'08:30', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (46, 36, CAST(N'2022-01-01T00:00:00.000' AS DateTime), N'Saturday', 1, 1, N'09:30', N'18:30', N'09:00', N'00:30', N'08:30', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (47, 36, CAST(N'2022-01-02T00:00:00.000' AS DateTime), N'Sunday', 1, 2, N'08:00', N'19:20', N'11:20', N'01:00', N'10:20', N'v', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (48, 36, CAST(N'2022-01-03T00:00:00.000' AS DateTime), N'Monday', 1, 3, N'10:00', N'17:00', N'07:00', N'00:30', N'06:30', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (49, 36, CAST(N'2022-01-04T00:00:00.000' AS DateTime), N'Tuesday', 1, 4, N'08:00', N'16:30', N'08:30', N'00:20', N'08:10', N'x', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (50, 36, CAST(N'2022-01-05T00:00:00.000' AS DateTime), N'Wednesday', 1, 5, N'07:00', N'18:40', N'11:40', N'00:40', N'11:00', N'x', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (51, 36, CAST(N'2022-01-06T00:00:00.000' AS DateTime), N'Thursday', 1, 6, N'08:30', N'19:20', N'10:50', N'01:00', N'09:50', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (52, 36, CAST(N'2022-01-07T00:00:00.000' AS DateTime), N'Friday', 1, 7, N'07:13', N'19:12', N'11:59', N'01:00', N'10:59', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (53, 36, CAST(N'2022-01-10T00:00:00.000' AS DateTime), N'Monday', 1, 10, N'08:00', N'19:22', N'11:22', N'03:00', N'08:22', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (54, 36, CAST(N'2022-01-11T00:00:00.000' AS DateTime), N'Tuesday', 1, 11, N'09:00', N'14:00', N'05:00', N'00:30', N'04:30', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (55, 36, CAST(N'2022-01-12T00:00:00.000' AS DateTime), N'Wednesday', 1, 12, N'08:00', N'15:59', N'07:59', N'01:00', N'06:59', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (56, 36, CAST(N'2022-01-13T00:00:00.000' AS DateTime), N'Thursday', 1, 13, N'07:30', N'18:59', N'11:29', N'03:00', N'08:29', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (57, 36, CAST(N'2022-01-17T00:00:00.000' AS DateTime), N'Monday', 1, 17, N'08:00', N'19:00', N'11:00', N'00:30', N'10:30', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (58, 36, CAST(N'2022-01-18T00:00:00.000' AS DateTime), N'Tuesday', 1, 18, N'08:29', N'17:00', N'08:31', N'00:15', N'08:16', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (59, 36, CAST(N'2022-01-19T00:00:00.000' AS DateTime), N'Wednesday', 1, 19, N'07:45', N'17:06', N'09:21', N'02:00', N'07:21', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (60, 36, CAST(N'2022-01-20T00:00:00.000' AS DateTime), N'Thursday', 1, 20, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (61, 36, CAST(N'2022-01-21T00:00:00.000' AS DateTime), N'Friday', 1, 21, N'07:00', N'18:00', N'11:00', N'02:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (62, 36, CAST(N'2022-01-24T00:00:00.000' AS DateTime), N'Monday', 1, 24, N'09:00', N'19:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (63, 36, CAST(N'2022-01-25T00:00:00.000' AS DateTime), N'Tuesday', 1, 25, N'09:00', N'18:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (64, 36, CAST(N'2022-01-26T00:00:00.000' AS DateTime), N'Wednesday', 1, 26, N'09:00', N'18:00', N'09:00', N'01:00', N'08:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (65, 36, CAST(N'2022-01-27T00:00:00.000' AS DateTime), N'Thursday', 1, 27, N'09:00', N'18:00', N'09:00', N'01:00', N'08:00', N'v', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (66, 36, CAST(N'2022-01-28T00:00:00.000' AS DateTime), N'Friday', 1, 28, N'09:00', N'18:00', N'09:00', N'00:30', N'08:30', N'x', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (67, 36, CAST(N'2022-01-31T00:00:00.000' AS DateTime), N'Monday', 1, 31, N'09:30', N'18:30', N'09:00', N'00:30', N'08:30', N'x', NULL, 1, 0, 0)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1046, 1035, CAST(N'2022-01-01T00:00:00.000' AS DateTime), N'Saturday', 1, 1, N'08:00', N'18:08', N'10:08', N'01:00', N'09:08', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1047, 1035, CAST(N'2022-01-03T00:00:00.000' AS DateTime), N'Monday', 1, 3, N'08:00', N'19:01', N'11:01', N'01:00', N'10:01', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1048, 1035, CAST(N'2022-01-04T00:00:00.000' AS DateTime), N'Tuesday', 1, 4, N'09:00', N'14:00', N'05:00', N'01:00', N'04:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1049, 1035, CAST(N'2022-01-05T00:00:00.000' AS DateTime), N'Wednesday', 1, 5, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1050, 1035, CAST(N'2022-01-06T00:00:00.000' AS DateTime), N'Thursday', 1, 6, N'08:30', N'17:00', N'08:30', N'00:30', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1051, 1035, CAST(N'2022-01-07T00:00:00.000' AS DateTime), N'Friday', 1, 7, N'09:00', N'17:00', N'08:00', N'01:00', N'07:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1052, 1035, CAST(N'2022-01-08T00:00:00.000' AS DateTime), N'Saturday', 1, 8, N'08:00', N'18:00', N'10:00', N'01:30', N'08:30', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1053, 1035, CAST(N'2022-01-10T00:00:00.000' AS DateTime), N'Monday', 1, 10, N'09:00', N'18:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1054, 1035, CAST(N'2022-01-11T00:00:00.000' AS DateTime), N'Tuesday', 1, 11, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1055, 1035, CAST(N'2022-01-12T00:00:00.000' AS DateTime), N'Wednesday', 1, 12, N'07:00', N'19:00', N'12:00', N'02:00', N'10:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1056, 1035, CAST(N'2022-01-13T00:00:00.000' AS DateTime), N'Thursday', 1, 13, N'08:00', N'18:30', N'10:30', N'00:30', N'10:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1057, 1035, CAST(N'2022-01-14T00:00:00.000' AS DateTime), N'Friday', 1, 14, N'08:00', N'18:00', N'10:00', N'02:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1058, 1035, CAST(N'2022-01-15T00:00:00.000' AS DateTime), N'Saturday', 1, 15, N'08:00', N'18:15', N'10:15', N'01:00', N'09:15', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1059, 1035, CAST(N'2022-01-17T00:00:00.000' AS DateTime), N'Monday', 1, 17, N'08:00', N'17:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1060, 1035, CAST(N'2022-01-18T00:00:00.000' AS DateTime), N'Tuesday', 1, 18, N'08:00', N'17:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1061, 1035, CAST(N'2022-01-19T00:00:00.000' AS DateTime), N'Wednesday', 1, 19, N'08:00', N'18:23', N'10:23', N'01:25', N'08:58', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1062, 1035, CAST(N'2022-01-20T00:00:00.000' AS DateTime), N'Thursday', 1, 20, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1063, 1035, CAST(N'2022-01-21T00:00:00.000' AS DateTime), N'Friday', 1, 21, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1064, 1035, CAST(N'2022-01-22T00:00:00.000' AS DateTime), N'Saturday', 1, 22, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1065, 1035, CAST(N'2022-01-24T00:00:00.000' AS DateTime), N'Monday', 1, 24, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1066, 1035, CAST(N'2022-01-25T00:00:00.000' AS DateTime), N'Tuesday', 1, 25, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1067, 1035, CAST(N'2022-01-26T00:00:00.000' AS DateTime), N'Wednesday', 1, 26, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'h', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1068, 1035, CAST(N'2022-01-27T00:00:00.000' AS DateTime), N'Thursday', 1, 27, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1069, 1035, CAST(N'2022-01-28T00:00:00.000' AS DateTime), N'Friday', 1, 28, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1070, 1035, CAST(N'2022-01-29T00:00:00.000' AS DateTime), N'Saturday', 1, 29, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1071, 1035, CAST(N'2022-01-31T00:00:00.000' AS DateTime), N'Monday', 1, 31, N'08:00', N'17:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1080, 1036, CAST(N'2022-01-01T00:00:00.000' AS DateTime), N'Saturday', 1, 1, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1081, 1036, CAST(N'2022-01-04T00:00:00.000' AS DateTime), N'Tuesday', 1, 4, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1082, 1036, CAST(N'2022-01-05T00:00:00.000' AS DateTime), N'Wednesday', 1, 5, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1083, 1036, CAST(N'2022-01-06T00:00:00.000' AS DateTime), N'Thursday', 1, 6, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1084, 1036, CAST(N'2022-01-07T00:00:00.000' AS DateTime), N'Friday', 1, 7, N'08:02', N'18:00', N'09:58', N'01:00', N'08:58', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1085, 1036, CAST(N'2022-01-08T00:00:00.000' AS DateTime), N'Saturday', 1, 8, N'08:02', N'18:00', N'09:58', N'01:30', N'08:28', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1086, 1036, CAST(N'2022-01-10T00:00:00.000' AS DateTime), N'Monday', 1, 10, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1087, 1036, CAST(N'2022-01-11T00:00:00.000' AS DateTime), N'Tuesday', 1, 11, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1088, 1036, CAST(N'2022-01-12T00:00:00.000' AS DateTime), N'Wednesday', 1, 12, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1089, 1036, CAST(N'2022-01-13T00:00:00.000' AS DateTime), N'Thursday', 1, 13, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1090, 1036, CAST(N'2022-01-14T00:00:00.000' AS DateTime), N'Friday', 1, 14, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1091, 1036, CAST(N'2022-01-15T00:00:00.000' AS DateTime), N'Saturday', 1, 15, N'08:00', N'18:00', N'10:00', N'01:59', N'08:01', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1092, 1036, CAST(N'2022-01-17T00:00:00.000' AS DateTime), N'Monday', 1, 17, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1093, 1036, CAST(N'2022-01-18T00:00:00.000' AS DateTime), N'Tuesday', 1, 18, N'08:00', N'19:00', N'11:00', N'02:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1094, 1036, CAST(N'2022-01-19T00:00:00.000' AS DateTime), N'Wednesday', 1, 19, N'09:00', N'18:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1095, 1036, CAST(N'2022-01-20T00:00:00.000' AS DateTime), N'Thursday', 1, 20, N'09:00', N'18:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1096, 1036, CAST(N'2022-01-21T00:00:00.000' AS DateTime), N'Friday', 1, 21, N'08:00', N'17:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1097, 1036, CAST(N'2022-01-22T00:00:00.000' AS DateTime), N'Saturday', 1, 22, N'08:00', N'18:08', N'10:08', N'01:00', N'09:08', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1098, 1036, CAST(N'2022-01-24T00:00:00.000' AS DateTime), N'Monday', 1, 24, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1099, 1036, CAST(N'2022-01-25T00:00:00.000' AS DateTime), N'Tuesday', 1, 25, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1100, 1036, CAST(N'2022-01-26T00:00:00.000' AS DateTime), N'Wednesday', 1, 26, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1101, 1036, CAST(N'2022-01-27T00:00:00.000' AS DateTime), N'Thursday', 1, 27, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1102, 1036, CAST(N'2022-01-28T00:00:00.000' AS DateTime), N'Friday', 1, 28, N'08:08', N'18:00', N'09:52', N'01:00', N'08:52', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1103, 1036, CAST(N'2022-01-29T00:00:00.000' AS DateTime), N'Saturday', 1, 29, N'08:08', N'18:00', N'09:52', N'01:00', N'08:52', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1104, 1036, CAST(N'2022-01-31T00:00:00.000' AS DateTime), N'Monday', 1, 31, N'08:08', N'18:00', N'09:52', N'01:00', N'08:52', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1105, 1037, CAST(N'2022-01-01T00:00:00.000' AS DateTime), N'Saturday', 1, 1, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1106, 1037, CAST(N'2022-01-03T00:00:00.000' AS DateTime), N'Monday', 1, 3, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1107, 1037, CAST(N'2022-01-04T00:00:00.000' AS DateTime), N'Tuesday', 1, 4, N'08:00', N'17:00', N'09:00', N'00:30', N'08:30', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1108, 1037, CAST(N'2022-01-05T00:00:00.000' AS DateTime), N'Wednesday', 1, 5, N'08:00', N'18:00', N'10:00', N'02:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1109, 1037, CAST(N'2022-01-06T00:00:00.000' AS DateTime), N'Thursday', 1, 6, N'08:00', N'18:00', N'10:00', N'01:25', N'08:35', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1110, 1037, CAST(N'2022-01-07T00:00:00.000' AS DateTime), N'Friday', 1, 7, N'08:00', N'17:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1111, 1037, CAST(N'2022-01-08T00:00:00.000' AS DateTime), N'Saturday', 1, 8, N'09:00', N'18:00', N'09:00', N'02:00', N'07:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1112, 1037, CAST(N'2022-01-10T00:00:00.000' AS DateTime), N'Monday', 1, 10, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1113, 1037, CAST(N'2022-01-11T00:00:00.000' AS DateTime), N'Tuesday', 1, 11, N'08:30', N'17:00', N'08:30', N'00:30', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1114, 1037, CAST(N'2022-01-14T00:00:00.000' AS DateTime), N'Friday', 1, 14, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1115, 1037, CAST(N'2022-01-15T00:00:00.000' AS DateTime), N'Saturday', 1, 15, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1116, 1037, CAST(N'2022-01-17T00:00:00.000' AS DateTime), N'Monday', 1, 17, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1117, 1037, CAST(N'2022-01-18T00:00:00.000' AS DateTime), N'Tuesday', 1, 18, N'08:00', N'17:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1118, 1037, CAST(N'2022-01-19T00:00:00.000' AS DateTime), N'Wednesday', 1, 19, N'09:00', N'19:00', N'10:00', N'02:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1119, 1037, CAST(N'2022-01-20T00:00:00.000' AS DateTime), N'Thursday', 1, 20, N'08:00', N'18:00', N'10:00', N'00:30', N'09:30', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1120, 1037, CAST(N'2022-01-21T00:00:00.000' AS DateTime), N'Friday', 1, 21, N'09:00', N'17:00', N'08:00', N'01:00', N'07:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1121, 1037, CAST(N'2022-01-22T00:00:00.000' AS DateTime), N'Saturday', 1, 22, N'08:00', N'17:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1122, 1037, CAST(N'2022-01-24T00:00:00.000' AS DateTime), N'Monday', 1, 24, N'08:00', N'18:00', N'10:00', N'01:00', N'09:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1123, 1037, CAST(N'2022-01-25T00:00:00.000' AS DateTime), N'Tuesday', 1, 25, N'09:00', N'17:00', N'08:00', N'01:00', N'07:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1124, 1037, CAST(N'2022-01-26T00:00:00.000' AS DateTime), N'Wednesday', 1, 26, N'08:00', N'17:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1125, 1037, CAST(N'2022-01-27T00:00:00.000' AS DateTime), N'Thursday', 1, 27, N'09:00', N'18:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1126, 1037, CAST(N'2022-01-28T00:00:00.000' AS DateTime), N'Friday', 1, 28, N'08:00', N'17:00', N'09:00', N'01:00', N'08:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1127, 1037, CAST(N'2022-01-29T00:00:00.000' AS DateTime), N'Saturday', 1, 29, N'09:00', N'17:00', N'08:00', N'01:00', N'07:00', N'w', NULL, 1, 0, 1)
GO
INSERT [dbo].[TimeRecordingSheetDetails] ([RecTimeSheetDetailsId], [EmpId], [Date], [Day], [Month], [DayNo], [EmpIn], [EmpOut], [Total], [EmpBreak], [Net], [Presence], [AttandanceStatus], [IsSubmitData], [IsActive], [IsApprove]) VALUES (1128, 1037, CAST(N'2022-01-31T00:00:00.000' AS DateTime), N'Monday', 1, 31, N'10:00', N'18:00', N'08:00', N'00:30', N'07:30', N'w', NULL, 1, 0, 1)
GO
SET IDENTITY_INSERT [dbo].[TimeRecordingSheetDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[UserDetails] ON 
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (1, 1, 1, N'1000', N'1000', N'ShobiAdmin', N'ShobiAdmin', N'info@shobigroup.com', N'9370903405', N'Sunny R Dewan.jpg', 1, N'10-12-2020')
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (2, 6, 6, N'1005', N'1005', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'9370903405', N'DP_2.png', 1, N'14-12-2020')
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (3, 6, 13, N'1010', N'1010', N'Makrand', N'Naik', N'makrand.naik@shobigroup.com', N'9370903402', N'DP_3.png', 1, N'15-12-2020')
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (6, 6, 19, N'1018', N'1018', N'Chaitanya', N'Kashyap', N'vivek.kulkarni@shobigroup.com', N'6666966666', N'default-avatar.png', 1, N'07-01-2021')
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (7, 4, 20, N'10080', N'10080', N'Vivek', N'Kulkarni', N'sdf@adsa.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (8, 4, 21, N'10081', N'10081', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (9, 4, 22, N'10082', N'10082', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (10, 4, 23, N'10083', N'10083', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (11, 4, 24, N'10084', N'10084', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (12, 4, 25, N'10085', N'10085', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (13, 4, 26, N'10086', N'10086', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (14, 4, 27, N'10087', N'10087', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (15, 4, 28, N'10088', N'10088', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (16, 4, 29, N'10089', N'10089', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (17, 4, 30, N'10090', N'10090', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (18, 4, 31, N'10091', N'10091', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (19, 4, 32, N'10092', N'10092', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (20, 4, 33, N'10093', N'10093', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (21, 4, 34, N'10094', N'10094', N'Vivek', N'Kulkarni', N'vivek.kulkarni@shobigroup.com', N'7898789787', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (22, 6, 36, N'2222', N'2222', N'PayRoll', N'Process', N'xyz@demo.com', N'9890044567', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (1023, 6, 1035, N'4', N'4', N'GHI', N'XYZ', N'pankajkhairnar9@gmail.com', N'8275602021', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (1024, 6, 1036, N'5', N'5', N'KLM', N'AVC', N'pankajkhairnar9@gmail.com', N'9545161758', N'default-avatar.png', 0, NULL)
GO
INSERT [dbo].[UserDetails] ([UserId], [RoleId], [EmployeeId], [UserName], [UserPassword], [FirstName], [LastName], [Email], [Contact], [ProfilePicturePath], [IsPwdChangeFT], [CreatedDate]) VALUES (1025, 6, 1037, N'6', N'6', N'OPQ', N'HJY', N'vivek.kulkarni@shobigroup.com', N'9452256215', N'default-avatar.png', 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[UserDetails] OFF
GO
/****** Object:  Index [IX_EmpReimbursement]    Script Date: 04-03-2022 20:46:30 ******/
CREATE NONCLUSTERED INDEX [IX_EmpReimbursement] ON [dbo].[EmpReimbursement]
(
	[EmployeeId] ASC,
	[IsActive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserDetails]    Script Date: 04-03-2022 20:46:30 ******/
ALTER TABLE [dbo].[UserDetails] ADD  CONSTRAINT [IX_UserDetails] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmpAddress] ADD  CONSTRAINT [DF_EmpAddress_IsPermanentAddress]  DEFAULT ((0)) FOR [IsPermanentAddress]
GO
ALTER TABLE [dbo].[LeaveApplyDetails]  WITH CHECK ADD  CONSTRAINT [FK_LeaveApplyDetails_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[LeaveApplyDetails] CHECK CONSTRAINT [FK_LeaveApplyDetails_Employee]
GO
ALTER TABLE [dbo].[LeaveApplyDetails]  WITH CHECK ADD  CONSTRAINT [FK_LeaveApplyDetails_LeaveStatusTypes] FOREIGN KEY([LeaveStatus])
REFERENCES [dbo].[LeaveStatusTypes] ([LeaveStatusTypeId])
GO
ALTER TABLE [dbo].[LeaveApplyDetails] CHECK CONSTRAINT [FK_LeaveApplyDetails_LeaveStatusTypes]
GO
ALTER TABLE [dbo].[LeaveApplyDetails]  WITH CHECK ADD  CONSTRAINT [FK_LeaveApplyDetails_LeaveTypes] FOREIGN KEY([LeaveType])
REFERENCES [dbo].[LeaveTypes] ([LeaveTypeId])
GO
ALTER TABLE [dbo].[LeaveApplyDetails] CHECK CONSTRAINT [FK_LeaveApplyDetails_LeaveTypes]
GO
ALTER TABLE [dbo].[LeaveTypes]  WITH CHECK ADD  CONSTRAINT [FK_LeaveTypes_LeaveTypeCategory] FOREIGN KEY([LeaveTypeCategoryId])
REFERENCES [dbo].[LeaveTypeCategory] ([LeaveTypeCategoryId])
GO
ALTER TABLE [dbo].[LeaveTypes] CHECK CONSTRAINT [FK_LeaveTypes_LeaveTypeCategory]
GO
/****** Object:  StoredProcedure [dbo].[EmpReimbursementDetails]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[EmpReimbursementDetails]
@EmpId int ,
@Id int
As
Begin
--Declare
--@EmpId int =0,
--@Id int =1

if(@Id=0 or @Id is null)
	Begin
		
		set @EmpId= isnull(@EmpId,0)
		select @EmpId=case when @EmpId is null then 0 else @EmpId end
		
		select 
			Id,EmployeeId,EmployeeNumber,EmployeeName,EarningsTypeFromLookUp,ET.Name as EarningsType,Convert(varchar(30),Date,103) as Date,Amount,
			Convert(varchar(30),PaymentEffectedDate,103) as PaymentEffectedDate,Remarks,ER.IsActive,ER.Status 
		from EmpReimbursement  ER inner join LookupDetailsM ET on ET.LookUpDetailsId=ER.EarningsTypeFromLookUp and ET.IsActive=0
		where (EmployeeId=  @EmpId or convert(varchar(10),@EmpId) =0) and ER.IsActive=1
	End
Else
	Begin
		Select 
			Id,EmployeeId,EmployeeNumber,EmployeeName,EarningsTypeFromLookUp,ET.Name as EarningsType,
			Convert(varchar(30),Date,120) as Date,
			--Date,
			Amount,
			Convert(varchar(10),PaymentEffectedDate,120) as PaymentEffectedDate,Remarks,Status
		from EmpReimbursement ER 
			inner join LookupDetailsM ET on ET.LookUpDetailsId=ER.EarningsTypeFromLookUp and ET.IsActive=0
		Where Id=@Id
	End
End

--exec EmpReimbursementDetails 0
GO
/****** Object:  StoredProcedure [dbo].[RPT_ApproveAllEmployeeReimbursementDetalis]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Pankaj Khairnar>
-- Create date: <31-12-2021>
-- Description:	<Approve Reimbursement Details>
-- =============================================
CREATE PROCEDURE [dbo].[RPT_ApproveAllEmployeeReimbursementDetalis]
@ReimbursementDetailsIds varchar(MAX)=null
AS 
BEGIN
declare @Status varchar(100)='Approved';
EXEC ('UPDATE EmpReimbursement SET Status ='''+@Status+''' ,ApprovedDate=GETDATE()                
              WHERE Id IN (' + @ReimbursementDetailsIds + ')')

	
END

--EXEC RPT_ApproveAllEmployeeReimbursementDetalis '3,5'

GO
/****** Object:  StoredProcedure [dbo].[RPT_ApproveAllEmployeeTimeSheetDetalis]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Pankaj Khairnar>
-- Create date: <28-10-2021>
-- Description:	<Approve Time Sheet Details>
-- =============================================
CREATE PROCEDURE [dbo].[RPT_ApproveAllEmployeeTimeSheetDetalis]
@timeSheetDetailsIds varchar(MAX)=null
AS 
BEGIN

EXEC ('UPDATE TimeRecordingSheetDetails SET IsApprove = 1                 
              WHERE    RecTimeSheetDetailsId IN (' + @timeSheetDetailsIds + ')')

	
END

GO
/****** Object:  StoredProcedure [dbo].[RPT_GetEmployeeTimeSheetDetalis]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pankaj Khairnar>
-- Create date: <28-10-2021>
-- Description:	<Get Time Sheet Details>
-- =============================================

CREATE PROCEDURE [dbo].[RPT_GetEmployeeTimeSheetDetalis]
@EmpId int,
@MonthId int,
@YearId int
AS 
BEGIN

 
 IF(@EmpId!=0)
 BEGIN
	select 
	TSH.RecTimeSheetDetailsId as recTimeSheetDetailsId,
	TSH.Day as day,
	TSH.DayNo as dayNo,
	CAST(EmpIn AS time) as empIn,
	Cast(EmpOut AS Time) as empOut,
	Cast(EmpBreak AS Time) as empBreak,
	Cast(Net AS Time) as net,
	Cast(Total AS Time) as total,
	case when LOWER(Presence) ='h' then 'Holiday,Weekend'
	when LOWER(Presence)='v' then 'Leave,Vacation'
	when LOWER(Presence)='x' then 'Invalid, Not Applicable Day'
	when LOWER(Presence)='w' then 'Irregular Working Day'
	else ''
	end as presence,
	ISNULL(IsApprove,0) as isApprove


from TimeRecordingSheetDetails TSH inner join Employee Emp on TSH.EmpId=EmployeeId and EMp.IsActive=1
Where EmpId=@EmpId and Month=@MonthId and YEAR(Date)=@YearId and ISNULL(TSH.IsSubmitData,0)=1
order by DayNo
END
ELSE
BEGIN
	select 
	TSH.RecTimeSheetDetailsId as recTimeSheetDetailsId,
	TSH.Day as day,
	TSH.DayNo as dayNo,
	CAST(EmpIn AS time) as empIn,
	Cast(EmpOut AS Time) as empOut,
	Cast(EmpBreak AS Time) as empBreak,
	Cast(Net AS Time) as net,
	Cast(Total AS Time) as total,
	case when LOWER(Presence) ='h' then 'Holiday,Weekend'
	when LOWER(Presence)='v' then 'Leave,Vacation'
	when LOWER(Presence)='x' then 'Invalid, Not Applicable Day'
	when LOWER(Presence)='w' then 'Irregular Working Day'
	else ''
	end as presence,
	ISNULL(IsApprove,0) as isApprove

from TimeRecordingSheetDetails TSH inner join Employee Emp on TSH.EmpId=EmployeeId and EMp.IsActive=1
Where Month=@MonthId and YEAR(Date)=@YearId and ISNULL(TSH.IsSubmitData,0)=1
order by DayNo
END

END
GO
/****** Object:  StoredProcedure [dbo].[RPT_GetEmployeeTimeSheetDetalisByRecordId]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pankaj Khairnar>
-- Create date: <28-10-2021>
-- Description:	<Get Time Sheet Details>
-- =============================================

CREATE PROCEDURE [dbo].[RPT_GetEmployeeTimeSheetDetalisByRecordId]
@timeSheetRecId int
AS 
BEGIN

 
 IF(@timeSheetRecId!=0)
 BEGIN
	select 
	TSH.RecTimeSheetDetailsId as recTimeSheetDetailsId,
	TSH.Day as day,
	TSH.DayNo as dayNo,
	CAST(EmpIn AS time) as empIn,
	Cast(EmpOut AS Time) as empOut,
	Cast(EmpBreak AS Time) as empBreak,
	Cast(Net AS Time) as net,
	Cast(Total AS Time) as total,
	case when LOWER(Presence) ='h' then 'Holiday,Weekend'
	when LOWER(Presence)='v' then 'Leave,Vacation'
	when LOWER(Presence)='x' then 'Invalid, Not Applicable Day'
	when LOWER(Presence)='w' then 'Irregular Working Day'
	else ''
	end as presence,
	ISNULL(IsApprove,0) as isApprove


from TimeRecordingSheetDetails TSH inner join Employee Emp on TSH.EmpId=EmployeeId and EMp.IsActive=1
Where  ISNULL(TSH.IsSubmitData,0)=1 and RecTimeSheetDetailsId=@timeSheetRecId
order by DayNo
END
ELSE
BEGIN
	select 
	TSH.RecTimeSheetDetailsId as recTimeSheetDetailsId,
	TSH.Day as day,
	TSH.DayNo as dayNo,
	CAST(EmpIn AS time) as empIn,
	Cast(EmpOut AS Time) as empOut,
	Cast(EmpBreak AS Time) as empBreak,
	Cast(Net AS Time) as net,
	Cast(Total AS Time) as total,
	case when LOWER(Presence) ='h' then 'Holiday,Weekend'
	when LOWER(Presence)='v' then 'Leave,Vacation'
	when LOWER(Presence)='x' then 'Invalid, Not Applicable Day'
	when LOWER(Presence)='w' then 'Irregular Working Day'
	else ''
	end as presence,
	ISNULL(IsApprove,0) as isApprove

from TimeRecordingSheetDetails TSH inner join Employee Emp on TSH.EmpId=EmployeeId and EMp.IsActive=1
Where ISNULL(TSH.IsSubmitData,0)=1
order by DayNo
END

END
GO
/****** Object:  StoredProcedure [dbo].[RPT_GetEmpReimbursementApproved]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RPT_GetEmpReimbursementApproved]
@EmpId int,
@EmpCode int,
@MonthId int
AS 
BEGIN

 
	select Id,EmployeeNumber,EmployeeName,Year(Date) as Year,Month(Date) as Month,convert(varchar(30),Date,103) as Date,Amount,
	convert(varchar(30),PaymentEffectedDate,103) as PaymentEffectedDate,Remarks	
	from EmpReimbursement 
	where EmployeeId=@EmpId and EmployeeNumber=@EmpCode and Status='Apply'
	and  Month(Date)=@MonthId

END

GO
/****** Object:  StoredProcedure [dbo].[RPT_GetTimeSheetDetalis]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pankaj Khairnar>
-- Create date: <28-10-2021>
-- Description:	<Get Time Sheet Details>
-- =============================================

CREATE PROCEDURE [dbo].[RPT_GetTimeSheetDetalis]
(@Parameters xml='')
AS 
BEGIN

--declare @Parameters xml
--set @Parameters ='
--<SpGetTimeSheetDetailsViewModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <year>2021</year>
--  <Month>10</Month>
--  <EmpCode>1005</EmpCode>
--  <EmpName>Vivek Kulkarni</EmpName>
--</SpGetTimeSheetDetailsViewModel>
--'

DECLARE @XmlDocumentHandle INT
	Declare @EmpId int
	Declare @EmpCode varchar(10)
	Declare @Month int
	Declare @Year int


--Declare @EmpId Bigint=6, @Month bigint=10, @Date varchar(10)='2021-10-01 00:00:00.000'


	EXEC sp_xml_preparedocument @XmlDocumentHandle OUTPUT, @Parameters
	select  @EmpId=EmpId,@EmpCode=EmpCode,@Month=Month, @Year = year
	FROM OPENXML (@XmlDocumentHandle, 'SpGetTimeSheetDetailsViewModel',2) WITH (EmpId int,EmpCode varchar(30), Month int,year int)
	EXEC sp_xml_removedocument @XmlDocumentHandle


Create Table #TimeSheetData(EmpId int,EmployeeNumber int,year int,Month int,Date Datetime,EmpName varchar(2000),INFrom Time,OutTill Time,Total Time,Net Time)
--Declare @Year bigint
--set @Year=left(@Date,4)

IF(@EmpId!=0 or @EmpCode !=0)
	BEGIN
		insert into #TimeSheetData
			select 
				EmpId,EmployeeNumber,@Year as Year,Month,Date,isnull(EMp.FirstName,'')+' '+isnull(EMP.MiddleName,'')+''+isnull(Emp.LastName,'') as EmployeeName,
				CAST(Date AS time) as InFrom,
				Cast(Date AS time) as OutTill,
				Cast(Total AS Time) as Total,Cast(Net AS Time) as Net
	
			from TimeRecordingSheetDetails TSH inner join Employee Emp on TSH.EmpId=EmployeeId and EMp.IsActive=1
			Where (EmpId=@EmpId or EmployeeNumber=@EmpCode) and Month=@Month 
	END
ELSE
	BEGIN
		insert into #TimeSheetData
		select 
			EmpId,EmployeeNumber,@Year as Year,Month,Date,isnull(EMp.FirstName,'')+' '+isnull(EMP.MiddleName,'')+''+isnull(Emp.LastName,'') as EmployeeName,
			CAST(EmpIn AS time) as InFrom,
			Cast(EmpOut AS Time) as OutTill,Cast(Total AS Time) as Total,Cast(Net AS Time) as Net
		from TimeRecordingSheetDetails TSH inner join Employee Emp on TSH.EmpId=EmployeeId and EMp.IsActive=1
		Where Month=@Month 
	END

select EmpId,year,Month,EmpName,min(convert(varchar(30),Date,103)) as InFrom,max(convert(varchar(30),Date,103)) as OutTill,Count(Total) as Total,Count(Net) as Net
from #TimeSheetData --WHere Month=@Month and EmpId=@EmpId and year=@Year
Group By year,Month,EmpName,EmpId
--FOR XML PATH('root')) as xml

Drop Table #TimeSheetData

END
GO
/****** Object:  StoredProcedure [dbo].[SAL_GetEmployeeDetails]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SAL_GetEmployeeDetails]
@EmpNo int
As
Begin

if((select count(*) from SalaryHeader where EmployeeNumber = @EmpNo) <> 0)
	BEGIN
		SELECT TOP 1 EMP.EmployeeId, EMP.EmployeeNumber, EMP.FirstName, EMP.MiddleName, 
		EMP.LastName, EMP.Gender, convert(varchar, EMP.DateOfJoining, 103) DateOfJoining, convert(varchar, EMP.DateOfBirth, 103) DateOfBirth, MD.MasterDataItemValue [Location],
		EPF.PFIsApplicable, EPF.PFAccountNo, EPF.AllowEPFExcessContribution, EPF.AllowEPSExcessContribution,
		EPF.ESICIsApplicable, EPF.ESICAccountNo,
		SH.VersionNumber, 
		SD.ID SalDetailID, SD.[Basic], SD.HRA, SD.Bonus, SD.OtherAllowance, SD.Overttime, 
		(select TOP 1 pt.ProfTax from TaxLocationProfTaxMapping pt where pt.LocationID = MD.MasterDataItemId) as ProfTax,
		SD.Loan, SD.AdvanceSalary, SD.EmployeeContributionPF, SD.EmployeeContributionESIC,
		SD.EmployerContributionPF, SD.EmployerContributionESIC, SD.MonthlyNetPay, SD.MonthlyGrossPay,
		SD.AnnualGrossSalary, SD.AnnualGrossCTC
		
		FROM Employee EMP
		INNER JOIN EmpPFESICDetails EPF ON EMP.EmployeeId = EPF.EmployeeID
		LEFT JOIN MasterDataItems MD  ON EMP.[Location] = MD.MasterDataItemId
		INNER JOIN SalaryHeader SH ON SH.EmployeeID = EMP.EmployeeId
		INNER JOIN SalaryDetails SD ON SD.HeaderID = SH.ID
		
		WHERE EMP.EmployeeNumber = @EmpNo
		AND SH.[Status] = 'Approved'
		
		ORDER BY SH.VersionNumber DESC
	END
ELSE
	BEGIN
		SELECT TOP 1 EMP.EmployeeId, EMP.EmployeeNumber, EMP.FirstName, EMP.MiddleName, 
		EMP.LastName, EMP.Gender, convert(varchar, EMP.DateOfJoining, 103) DateOfJoining, convert(varchar, EMP.DateOfBirth, 103) DateOfBirth, MD.MasterDataItemValue [Location],
		EPF.PFIsApplicable, EPF.PFAccountNo, EPF.AllowEPFExcessContribution, EPF.AllowEPSExcessContribution,
		EPF.ESICIsApplicable, EPF.ESICAccountNo,
		0 as VersionNumber, 
		NULL as SalDetailID, 0 as [Basic], 0 as HRA, 0 as Bonus, 0 as OtherAllowance, 0 as Overttime, 
		isnull((select TOP 1 isnull(pt.ProfTax,0) from TaxLocationProfTaxMapping pt where pt.LocationID = MD.MasterDataItemId),0) as ProfTax,
		0 as Loan, 0 as AdvanceSalary, 0 as EmployeeContributionPF, 0 as EmployeeContributionESIC,
		0 as EmployerContributionPF, 0 as EmployerContributionESIC, 0 as MonthlyNetPay, 0 as MonthlyGrossPay,
		0 as AnnualGrossSalary, 0 as AnnualGrossCTC
		
		FROM Employee EMP
		INNER JOIN EmpPFESICDetails EPF ON EMP.EmployeeId = EPF.EmployeeID
		LEFT JOIN MasterDataItems MD  ON EMP.[Location] = MD.MasterDataItemId
		
		WHERE EMP.EmployeeNumber = @EmpNo
		
	END

End

--exec SAL_GetEmployeeDetails 4
--exec SAL_GetEmployeeDetails 1005



GO
/****** Object:  StoredProcedure [dbo].[SAL_GetSalaryMonthlyStatement]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SAL_GetSalaryMonthlyStatement]
 @Month int
As
Begin

SELECT ID,EmployeeID, EmployeeNumber, EmployeeName, convert(varchar(30),DOJ,103) as DOJ, DaysInMonth,
LOPDays, TotalWorkingDays, PayoutMonth, VersionNumber, [Basic], HRA, Bonus,
OtherAllowance, Overttime, ProfTax, Arrears, Reimbursement, Loan, 
AdvanceSalary, MonthlyPF, MonthlyESIC, MonthlyNetPay, MonthlyGrossPay, 
TotalDeduction, NetPay--, IsActive
FROM SalaryMonthlyStatement
--WHERE PayoutMonth = @Month
End

--exec SAL_GetSalaryMonthlyStatement 1
GO
/****** Object:  StoredProcedure [dbo].[Usp_GetLoanDetails]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Usp_GetLoanDetails]
 @EmpId int
As
Begin
--Declare @EmpId int=6
select 
	ID ,convert(varchar(30),DateOfLoan,103) as Date,LoanType,LoanAmount as Amount,PrincipalBalance as [ToPrincipale],InterestBalance as [ToInterest],
	0 as [ActualPrincipal],0 as [ActualInterest],Remarks,0 as [PerkValue], 0 as [PerkAmt],0 as [PerkRate]
from LoanHeader where EmployeeID=@EmpId and IsActive=0
End

--exec Usp_GetLoanDetails 6
GO
/****** Object:  StoredProcedure [dbo].[Usp_RPT_Get_DeductionPaySlipPrint]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Pankaj Khairnar>
-- Create date: <04-02-2022>
-- Description: <Insert Salary Process Data>
-- =============================================
CREATE PROCEDURE [dbo].[Usp_RPT_Get_DeductionPaySlipPrint]
@EmpID int,@MonthId int,@Year int
As
Begin
select * from (
select L.Name,SUM(Amount) as Amount from EmpReimbursement E inner join LookupDetailsM L on E.EarningsTypeFromLookUp=L.LookUpDetailsId and L.IsActive=0
where EmployeeId=@EmpID and Status='Approved' and ComponentsType='Deduction' and month(PaymentEffectedDate)=@MonthId and Year(PaymentEffectedDate)=@Year and E.IsActive=1
Group by L.Name
) as t

End


--exec Usp_RPT_Get_DeductionPaySlipPrint 1035,1,2022
GO
/****** Object:  StoredProcedure [dbo].[Usp_RPT_Get_EarningPaySlipPrint]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Pankaj Khairnar>
-- Create date: <04-02-2022>
-- Description: <Insert Salary Process Data>
-- =============================================
CREATE PROCEDURE [dbo].[Usp_RPT_Get_EarningPaySlipPrint]
@EmpID int,@MonthId int,@Year int
As
Begin
select * from (
select L.Name as Name,SUM(Amount) as Amount from EmpReimbursement E inner join LookupDetailsM L on E.EarningsTypeFromLookUp=L.LookUpDetailsId and L.IsActive=0
where EmployeeId=@EmpID and Status='Approved' and ComponentsType='Earnings' and month(PaymentEffectedDate)=@MonthId and Year(PaymentEffectedDate)=@Year and E.IsActive=1
Group by L.Name
) as t


End

--exec Usp_RPT_Get_EarningPaySlipPrint 1035,1,2022
GO
/****** Object:  StoredProcedure [dbo].[Usp_RPT_Get_PaySlipPrint]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Pankaj Khairnar>
-- Create date: <04-02-2022>
-- Description: <Insert Salary Process Data>
-- =============================================
CREATE PROCEDURE [dbo].[Usp_RPT_Get_PaySlipPrint]
@EmpID int,@MonthId int,@Year int
As
Begin

--Declare @EmPId int=36,@MonthId int=1,@Year int=2022

select 
		--Emp.EmployeeId,
		PayoutMonth as PayoutMonth,PayoutYR,
		Emp.FirstName +''+EMP.MiddleName+''+Emp.LastName as [Name],
		Convert(varchar(50),Emp.DateOfJoining,106) as DOJ ,
		isnull(Designation,'') as Designation,
		D.MasterDataItemValue as Department,
		
		M.MasterDataItemValue as LocationName,TotalWorkingDays,LOPDays,
		Emp.EmployeeNumber,'Sate Bank Of India' as BankName,7581245121 as [BankAccountNo],
		isnull(PANNumber,'') as PANNumber,Isnull(PFNumber,'') as PFNumber,isnull(UANNumber,'') as UANNumber,

		Basic,HRA,Bonus,OtherAllowance,0 as VARIABLEBONUS,MonthlyPF  as [PF],MonthlyESIC as [ESI],ProfTax as [PROFTAX],
		MonthlyGrossPay as [TotalEarningsINR],TotalDeduction as [TotalDeductionsINR],
		NetPay as NetPay,dbo.fnNumberToWords(NetPay) as NetPayInWord

	from SalaryMonthlyStatement Sal inner join Employee EMP on EMP.EmployeeId=Sal.EmployeeID
								    inner join MasterDataItems M on M.MasterDataItemId=EMP.Location
									inner join MasterDataItems D on D.MasterDataItemId=Emp.Department and Isnull(D.IsActive,1)=1
	WHere Sal.EmployeeID=@EmpID and MONTH(@MonthId)=@MonthId and Sal.IsActive=1

End

--exec Usp_RPT_Get_PaySlipPrint 1035,1,2022
GO
/****** Object:  StoredProcedure [dbo].[Usp_RPT_Get_ProcessSalaryMonthSlip]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Pankaj Khairnar>
-- Create date: <04-02-2022>
-- Description: <Insert Salary Process Data>
-- =============================================
CREATE PROCEDURE [dbo].[Usp_RPT_Get_ProcessSalaryMonthSlip]
@EmpID int,@MonthId int,@Year int
As
Begin
--Declare @EmpID int =36,@MonthId int =1,@Year int=2022

	Create table #ABC 
(EmployeeID varchar(MAX),Name varchar(MAX),EmployeeNumber varchar(MAX),[Joining Date] varchar(MAX),Designation varchar(MAX),
Department varchar(MAX),Location varchar(MAX),[Effective Work Days] varchar(MAX),LOP varchar(MAX),[Employee No] varchar(MAX),[Bank Name] varchar(MAX),
[Bank Account No] varchar(MAX),[PAN Number]varchar(MAX),[PF No] varchar(MAX),[PF UAN] varchar(MAX),Basic varchar(MAX),HRA varchar(MAX),
Bonus varchar(MAX),[SPECIAL ALLOWANCE] varchar(MAX),[VARIABLE BONUS] varchar(MAX),[PF] varchar(MAX),[ESI] varchar(MAX),[PROF TAX] varchar(MAX),
[Total Earnings:INR.] varchar(MAX),[Total Deductions:INR.]varchar(MAX))

insert  into #ABC
select 
		Sal.EmployeeID,EmployeeName as [Name],Sal.EmployeeNumber,Convert(varchar(30),DOJ,103) as [Joining Date],
		isnull(Designation,'ASD') as Designation,Department,M.MasterDataItemValue,TotalWorkingDays as [Effective Work Days],LOPDays,
		Sal.EmployeeNumber as [Employee No],'ABC' as [Bank Name],00112321 as [Bank Account No],
		PANName as [PAN Number],isnull(PFNumber,'PF No') as [PF No],UANNumber as [PF UAN],
		Basic,HRA,Bonus,OtherAllowance as [SPECIAL ALLOWANCE],0 as [VARIABLE BONUS],MonthlyPF  as [PF],MonthlyESIC as [ESI],ProfTax as [PROF TAX],
		MonthlyGrossPay as [Total Earnings:INR.],TotalDeduction as [Total Deductions:INR.]

	from SalaryMonthlyStatement Sal inner join Employee EMP on EMP.EmployeeId=Sal.EmployeeID
								    inner join MasterDataItems M on M.MasterDataItemId=EMP.Location
	WHere Sal.EmployeeID=@EmpID and MONTH(@MonthId)=@MonthId and Sal.IsActive=1


	Create Table #EmpDetailsSection(ID INT IDENTITY(1, 1),EmpDetails varchar(MAX),EmpDetailsVale varchar(MAX))
	Create Table #EmpDetailsSection1(ID INT IDENTITY(1, 1),EmpDetails1 varchar(MAX),EmpDetailsVale1 varchar(MAX))
	Create Table #Earning(ID INT IDENTITY(1, 1),EarningDetails varchar(MAX),EarningVale varchar(MAX))
	Create Table #Deduction(ID INT IDENTITY(1, 1),DeductionDetails varchar(MAX),DeductionVale varchar(MAX))

	insert into #EmpDetailsSection(EmpDetailsVale)Values('Employee') 
	insert into #EmpDetailsSection1(EmpDetails1)Values('Details') 
	insert into #EmpDetailsSection1(EmpDetails1)Values(null) 
	insert into #EmpDetailsSection
	SELECT EmpDetails,EmpDetailsVale FROM
		(select [Name],[Joining Date],Designation,Department,Location,[Effective Work Days],LOP
			FROM #ABC AS t
		) AS p
		UNPIVOT (EmpDetailsVale FOR EmpDetails IN ([Name],[Joining Date],Designation,Department,Location,[Effective Work Days],LOP)) AS unp 
	
	

	insert into #EmpDetailsSection1
	SELECT  EmpDetails1,EmpDetailsVale1 FROM
		(select [Employee No],[Bank Name],[Bank Account No],[PAN Number],[PF No],[PF UAN]
			FROM #ABC AS t
		) AS p
		UNPIVOT (EmpDetailsVale1 FOR EmpDetails1 IN ([Employee No],[Bank Name],[Bank Account No],[PAN Number],[PF No],[PF UAN])) AS unp 
		
		
		insert into #Earning(EarningDetails)Values('Deta')
		insert into #Earning
		SELECT  Earning,EarningVale FROM
		(select Basic,HRA,Bonus,[SPECIAL ALLOWANCE],[VARIABLE BONUS]
			FROM #ABC AS t
		) AS p
		UNPIVOT (EarningVale FOR Earning IN (Basic,HRA,Bonus,[SPECIAL ALLOWANCE],[VARIABLE BONUS])) AS unp 
	
		
		insert into #Deduction(DeductionDetails)Values('Dedcution')
		insert into #Deduction
		SELECT  Deduction,DeductionValue FROM
		(select PF,ESI,[PROF TAX]
			FROM #ABC AS t
		) AS p
		UNPIVOT (DeductionValue FOR Deduction IN (PF,ESI,[PROF TAX])) AS unp 
	
	Create Table #Final(ID INT IDENTITY(1, 1),EmpDetails varchar(MAX),EmpDetailsVale varchar(MAX),EmpDetails1 varchar(MAX),EmpDetailsVale1 varchar(MAX))

	 insert into #Final
	 select EmpDetails+' :',EmpDetailsVale,EmpDetails1+' :',EmpDetailsVale1 from #EmpDetailsSection a left join #EmpDetailsSection1 b on a.ID=b.ID
	 Union All
	 select EarningDetails+' :',EarningVale,DeductionDetails+' :',DeductionVale from #Earning a left join #Deduction b on a.ID=b.ID
	 
	 select  * from #Final

Drop table #EmpDetailsSection
Drop table #EmpDetailsSection1
Drop table #Earning
Drop table #Deduction
drop table #ABC
drop table #Final
End
GO
/****** Object:  StoredProcedure [dbo].[Usp_RPT_ProcessSalaryMonthStatment]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Pankaj Khairnar>
-- Create date: <31-01-2022>
-- Description: <Insert Salary Process Data>
-- =============================================
CREATE PROCEDURE [dbo].[Usp_RPT_ProcessSalaryMonthStatment]
@Month int,@Year int,@TotalHoliday int
As
Begin

--Declare @Month int=1,@Year int=2022,@TotalHoliday int=7

select
RecTimeSheetDetailsId,EmpId,Convert(varchar(30),Date,103) as Date,DAY,
EmpIn,EmpOut,Total,EmpBreak,Net
into #TimeSheetData
from TimeRecordingSheetDetails Where IsApprove=1 and IsActive=0 and Month=@Month and Presence='w'

Declare @NoOfWoringDays decimal(18,2),@NoOfDay int,@NoOfMontDay int

Declare @EmpID int
DECLARE ProcessSal_cursor CURSOR
	
	FOR SELECT distinct EmpId From #TimeSheetData
		OPEN ProcessSal_cursor;
			FETCH NEXT FROM ProcessSal_cursor INTO @EmpID
				WHILE @@FETCH_STATUS = 0
					BEGIN
						-- ================================ LOP Day =============================
							Declare @LOPDays decimal(18,2) 
							select @LOPDays=SUM(Cast(TotalLOPDays as decimal(18,2))) 
							from EmpLOPDetails a inner join LookupDetailsM b on a.LOPMonth=b.LookUpDetailsId
							where a.IsActive=1 and b.IsActive=0 and EmployeeID=@EmpID and Name=@Month

							
						-- ================================ LOP Day END =============================

						-- ================================ Earning & Deduction =============================

						Declare @EarningAmt decimal(18,2),@DeductionAmt decimal(18,2)

						select @EarningAmt=SUM(Amount)from EmpReimbursement E 
						where EmployeeId=@EmpID and Status='Approved' and ComponentsType='Earnings' and month(PaymentEffectedDate)=@Month and Year(PaymentEffectedDate)=@Year and E.IsActive=1
						
						select @DeductionAmt=SUM(Amount) from EmpReimbursement E 
						where EmployeeId=@EmpID and Status='Approved' and ComponentsType='Deduction' and month(PaymentEffectedDate)=@Month and Year(PaymentEffectedDate)=@Year and E.IsActive=1
						
						-- ================================ Earning & Deduction END =============================


						--================================ Leave Count Cal ================================
						Create Table #LeaveDate (EmpLeaveId int,LeaveFromDate date,LeaveToDate date)
						insert into #LeaveDate
						SELECT EmployeeId,convert(Date,LeaveFromDate,103) AS LeaveFromDate,convert(Date,LeaveToDate,103)  AS LeaveToDate
						FROM LeaveApplyDetails WHERE EmployeeId=@EmpID AND LeaveStatus=2
						
						;With CTE_leave AS (
						select * from #LeaveDate where Month(LeaveFromDate) <> Month(LeaveToDate) )
						
						SELECT a.EmpLeaveId,DATEPART(MONTH,LeaveFromDate) as MonthInNo,  DATENAME(MONTH,LeaveFromDate ) Month ,SUM(a.LeaveCount) LeaveTaken
						into #MonthWiseLeaveCount
						FROM 
							(
								SELECT C.EmpLeaveId, C.LeaveFromDate, DATEDIFF(DD,C.LeaveFromDate,EOMonth(LeaveFromDate) ) + 1 LeaveCount
								FROM CTE_Leave C
									UNION
								SELECT C.EmpLeaveId, DATEADD(DD,1, EOMonth(LeaveFromDate)) fromDate, DATEDIFF(DD,DATEADD(DD,1, EOMonth(LeaveFromDate)), C.LeaveToDate) + 1 LeaveCount
								FROM CTE_Leave C
									UNION
								SELECT EmpLeaveId, LeaveFromDate,  DATEDIFF(DD, LeaveFromDate, LeaveToDate) + 1 LeaveCount FROM #LeaveDate where Month(LeaveFromDate) = Month(LeaveToDate) 
							) a
						group by a.EmpLeaveId,DATEPART(MONTH,LeaveFromDate),DATENAME(MONTH,LeaveFromDate)
						
						Declare @Leave int 
						select @Leave=LeaveTaken from #MonthWiseLeaveCount where MonthInNo=@Month 
						
						--================================ Leave Count Cal End ================================
						
						select @NoOfWoringDays=Count(*)
						from #TimeSheetData where EmpId=@EmpID
						SELECT @NoOfDay=day(dateadd(m, @month + datediff(m, 0, cast(@year as char(4))), -1))
						SELECT @NoOfMontDay=Month(dateadd(m, @month + datediff(m, 0, cast(@year as char(4))), -1))

						
						select @NoOfWoringDays=((isnull(@NoOfWoringDays,0)+isnull(@TotalHoliday,0))-(isnull(@Leave,0)))
						select @NoOfWoringDays=@NoOfWoringDays-isnull(@LOPDays,0.0)
						
						select @NoOfWoringDays

						--Declare @FinalNoOfWoringDays decimal(18,2)
						--select @FinalNoOfWoringDays=cast(@NoOfWoringDays as decimal(18,2))-isnull(@LOPDays,0)


						insert into SalaryMonthlyStatement
						(SalaryDetailsId,EmployeeID,EmployeeNumber,EmployeeName,DOJ,DaysInMonth,LOPDays,TotalWorkingDays,PayoutMonth,VersionNumber,EarningsComponentsAmt,DeductionComponentsAmt,Basic,HRA,Bonus,OtherAllowance,Overttime,ProfTax,Arrears,Loan,Reimbursement,AdvanceSalary,MonthlyPF,MonthlyESIC,MonthlyNetPay,MonthlyGrossPay,TotalDeduction,NetPay,IsActive,CreatedDate,MailSendStatus,PayoutMonthInNo,PayoutYR)
						select
						SD.Id as SalDetailsId,SH.EmployeeID,EmployeeNumber,EmployeeName,DOJ,@NoOfDay as DaysInMonth,
						isnull(@LOPDays,0) as LOPDay,cast(@NoOfWoringDays as decimal(18,2)) as TotalWorkingDay,DateName( month , DateAdd( month , @NoOfMontDay , 0 ) - 1 ) as PayoutMonth,
						VersionNumber,
						
						ROUND(Isnull(@EarningAmt,0),0) as EarniingAmt,
						ROUND(isnull(@DeductionAmt,0),0) as DedcutionAmt,

						--================================ Gross Salary ================================
						ROUND(convert(decimal(18,2),Basic/@NoOfDay*@NoOfWoringDays),0) as CalBasic,
						ROUND(convert(decimal(18,2),HRA/@NoOfDay*@NoOfWoringDays),0) as CalHRA,
						ROUND(convert(decimal(18,2),Bonus/@NoOfDay*@NoOfWoringDays),0) as CalBonus,
						ROUND(convert(decimal(18,2),OtherAllowance/@NoOfDay*@NoOfWoringDays),0) as CalOtherAllowance,
						ROUND(Overttime,0) as Overtime,
						-- ================================ END ================================

						--================================ Deduction ================================
						case When  DateName( month , DateAdd( month , @NoOfMontDay , 0 ) - 1 )='February' then 300  else ProfTax end as ProfTax,
						0 as Arrears,Loan as Loan,0 as Reimbursement,AdvanceSalary,
						
						ROUND(case When convert(decimal(18,2),Basic/@NoOfDay*@NoOfWoringDays)<15000 then convert(decimal(18,2),Basic/@NoOfDay*@NoOfWoringDays)*0.12
						else (EmployeeContributionPF)+(EmployeeContributionESIC) end,0) as MonthlyPF,
						
						--(EmployeeContributionPF)+(EmployeeContributionESIC) as MonthlyPF,
						

						ROUND(Case When MonthlyGrossPay<21000 then (convert(decimal(18,2),Basic/@NoOfDay*@NoOfWoringDays)+
						convert(decimal(18,2),HRA/@NoOfDay*@NoOfWoringDays) +
						convert(decimal(18,2),Bonus/@NoOfDay*@NoOfWoringDays)+
						convert(decimal(18,2),OtherAllowance/@NoOfDay*@NoOfWoringDays) +Isnull(@EarningAmt,0)+
						Overttime)*0.0075
						else 
						EmployerContributionESIC end,0) as MonthlyESIC,

						--================================END================================

						0 as MonthlyNetPay,
						
						--================================ Monthly Gross ================================

						ROUND(convert(decimal(18,2),Basic/@NoOfDay*@NoOfWoringDays)+
						convert(decimal(18,2),HRA/@NoOfDay*@NoOfWoringDays) +
						convert(decimal(18,2),Bonus/@NoOfDay*@NoOfWoringDays)+
						convert(decimal(18,2),OtherAllowance/@NoOfDay*@NoOfWoringDays) +Isnull(@EarningAmt,0)+
						Overttime,0) as MonthlyGrossPay,

						
						--================================ Monthly Gross END ================================


						-- ================================ Total Deduction ================================

						--case When  DateName( month , DateAdd( month , @NoOfMontDay , 0 ) - 1 )='February' then 300  else ProfTax end +
						--0 +Loan +0 + AdvanceSalary+isnull(@DeductionAmt,0)+
						--(EmployeeContributionPF)+(EmployeeContributionESIC)+
						--Case When MonthlyGrossPay<21000 then (EmployerContributionPF)+(EmployerContributionESIC)
						--else EmployerContributionESIC end
						--as TotalDeduction,
						ROUND(
						(case When convert(decimal(18,2),Basic/@NoOfDay*@NoOfWoringDays)<15000 then convert(decimal(18,2),Basic/@NoOfDay*@NoOfWoringDays)*0.12
						else (EmployeeContributionPF)+(EmployeeContributionESIC) end)
							+
						(Case When MonthlyGrossPay<21000 then (convert(decimal(18,2),Basic/@NoOfDay*@NoOfWoringDays)+
						convert(decimal(18,2),HRA/@NoOfDay*@NoOfWoringDays) +
						convert(decimal(18,2),Bonus/@NoOfDay*@NoOfWoringDays)+
						convert(decimal(18,2),OtherAllowance/@NoOfDay*@NoOfWoringDays) +Isnull(@EarningAmt,0)+
						Overttime)*0.0075 else EmployerContributionESIC end)
							+
						(case When  DateName( month , DateAdd( month , @NoOfMontDay , 0 ) - 1 )='February' then 300  else ProfTax end)
							+
						(isnull(@DeductionAmt,0)),0)
						 as TotalDeduction,

						--================================ Total Deduction END ================================

						--================================ Monthly Net Pay ================================

						--(convert(decimal(18,2),Basic/@NoOfDay*@NoOfWoringDays)+
						--convert(decimal(18,2),HRA/@NoOfDay*@NoOfWoringDays) +
						--convert(decimal(18,2),Bonus/@NoOfDay*@NoOfWoringDays)+
						--convert(decimal(18,2),OtherAllowance/@NoOfDay*@NoOfWoringDays)+Isnull(@EarningAmt,0))-
						--(
						--case When  DateName( month , DateAdd( month , @NoOfMontDay , 0 ) - 1 )='February' then 300  else ProfTax end +
						--0 +Loan +0 + AdvanceSalary+isnull(@DeductionAmt,0)+
						--(EmployeeContributionPF)+(EmployeeContributionESIC)+
						--Case When MonthlyGrossPay<21000 then (EmployerContributionPF)+(EmployerContributionESIC)
						--else EmployerContributionESIC end
						--)
						--as NetPay,
						ROUND(
						(convert(decimal(18,2),Basic/@NoOfDay*@NoOfWoringDays)+
						convert(decimal(18,2),HRA/@NoOfDay*@NoOfWoringDays) +
						convert(decimal(18,2),Bonus/@NoOfDay*@NoOfWoringDays)+
						convert(decimal(18,2),OtherAllowance/@NoOfDay*@NoOfWoringDays) +Isnull(@EarningAmt,0)+
						Overttime)
							-
						(
							(case When convert(decimal(18,2),Basic/@NoOfDay*@NoOfWoringDays)<15000 then convert(decimal(18,2),Basic/@NoOfDay*@NoOfWoringDays)*0.12
						else (EmployeeContributionPF)+(EmployeeContributionESIC) end)
							+
						(Case When MonthlyGrossPay<21000 then (convert(decimal(18,2),Basic/@NoOfDay*@NoOfWoringDays)+
						convert(decimal(18,2),HRA/@NoOfDay*@NoOfWoringDays) +
						convert(decimal(18,2),Bonus/@NoOfDay*@NoOfWoringDays)+
						convert(decimal(18,2),OtherAllowance/@NoOfDay*@NoOfWoringDays) +Isnull(@EarningAmt,0)+
						Overttime)*0.0075 else EmployerContributionESIC end)
							+
						(case When  DateName( month , DateAdd( month , @NoOfMontDay , 0 ) - 1 )='February' then 300  else ProfTax end)
							+
						(isnull(@DeductionAmt,0))
						),0) as NetPay,



						--================================ Monthly Net Pay END ================================

						1 as IsActive,getdate() as CreatedDate,'Pending' as MailSendStatus,@Month as PayoutMonthInNo,@Year as PayoutYR
						
						from SalaryHeader SH inner join SalaryDetails SD On SH.ID=SD.HeaderID
						Where SH.IsActive=1 
						and VersionNumber = (Select MAX(VersionNumber) from SalaryHeader where IsActive=1 and Status='Approved' and PayoutMonth=@Month and EmployeeID=@EmpID)
						and Status='Approved' and PayoutMonth=@Month
						and SH.IsActive=1 and SD.IsActive=1 and SH.EmployeeID=@EmpID
						
						FETCH NEXT FROM ProcessSal_cursor INTO @EmpId;
						Drop Table #LeaveDate
						Drop table #MonthWiseLeaveCount
					END;
					
				CLOSE ProcessSal_cursor;
			DEALLOCATE ProcessSal_cursor;
		select 1 as Id
		Drop table #TimeSheetData
		
		
End
--Exec Usp_RPT_ProcessSalaryMonthStatment 1,2022,6
GO
/****** Object:  StoredProcedure [dbo].[Usp_RPT_SendMail_SalarySlip]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Pankaj Khairnar>
-- Create date: <09-02-2022>
-- Description: <Insert Salary Process Data>
-- =============================================
CREATE PROCEDURE [dbo].[Usp_RPT_SendMail_SalarySlip]
@Month int,@Year int
As
Begin
--Declare @MonthId int =1,@yearId int =2022
	select 
		Sal.ID,Emp.EmployeeId,isnull(Emp.FirstName,'') +' '+isnull(Emp.MiddleName,'')+' '+isnull(Emp.LastName,'') as EmployeeName,convert(varchar(30),isnull(Emp.DateOfJoining,''),103) AS DOJ,
		Sal.DaysInMonth,Sal.LOPDays as LOP,TotalWorkingDays,PayoutMonth as [Month],
		Basic,HRA,Bonus,OtherAllowance,Overttime,ProfTax,Arrears,Reimbursement,Loan,AdvanceSalary,MonthlyPF,MonthlyESIC,TotalDeduction,NetPay
	from SalaryMonthlyStatement Sal 
				   inner join Employee Emp on Sal.EmployeeID=Emp.EmployeeId and Emp.IsActive=1
	Where PayoutMonthInNo=@Month and PayoutYR=@Year and sal.IsActive=1 and MailSendStatus='Pending'
End

--Exec Usp_RPT_SendMail_SalarySlip 1,2022
GO
/****** Object:  StoredProcedure [dbo].[USpMEmpReimbursementDetails]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[USpMEmpReimbursementDetails]
As
Begin
	select * from EmpReimbursement where IsActive=1
End

GO
/****** Object:  StoredProcedure [dbo].[UspSalaryDetails]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[UspSalaryDetails]
@SalHeaderId int 
As
Begin

	--Declare @SalHeaderId int=4
	
	select 
		a.ID as SalDetaildId,HeaderID,b.EmployeeName,Basic,HRA,Bonus,OtherAllowance,Overttime,ProfTax,Loan,AdvanceSalary,
		EmployeeContributionPF,EmployeeContributionESIC,EmployerContributionPF,EmployerContributionESIC,
		MonthlyNetPay,MonthlyGrossPay,AnnualGrossSalary,AnnualGrossCTC
	into #TempData
	from SalaryDetails a inner join SalaryHeader b on a.HeaderID=b.ID
	Where HeaderID=@SalHeaderId and a.IsActive=1 and b.IsActive=1

SELECT SingalColName,ColValue FROM
  (SELECT Basic,HRA,Bonus,OtherAllowance,Overttime,ProfTax,Loan,AdvanceSalary,EmployeeContributionPF,EmployeeContributionESIC,EmployerContributionPF,EmployerContributionESIC,MonthlyNetPay,MonthlyGrossPay,AnnualGrossSalary,AnnualGrossCTC
    FROM #TempData AS t
  ) AS p
  UNPIVOT (ColValue FOR SingalColName IN (Basic,HRA,Bonus,OtherAllowance,Overttime,ProfTax,Loan,AdvanceSalary,EmployeeContributionPF,EmployeeContributionESIC,EmployerContributionPF,EmployerContributionESIC,MonthlyNetPay,MonthlyGrossPay,AnnualGrossSalary,AnnualGrossCTC)) AS unp
  Drop table #TempData

End
--Exec UspSalaryDetails 4
GO
/****** Object:  StoredProcedure [dbo].[UspSalaryHeader]    Script Date: 04-03-2022 20:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[UspSalaryHeader]
As
Begin
	
	select 
		Id as SalHeaderId,EmployeeID,EmployeeNumber,EmployeeName,EmployeeType,PFAvailability,
		convert(varchar(30),DOJ,105) as DOJ,
		convert(varchar(30),DOB,105) as DOB,
		convert(varchar(30),LastPayrollProceesedDate,105) as LastPayrollProceesedDate,
		PayoutMonth,Remarks,
		Convert(Varchar(30),EffectiveEndDate,105) as EffectiveEndDate,
		Convert(Varchar(30),EffectiveStartDate,105) as EffectiveStartDate
	from SalaryHeader where IsActive=1 and Status='Submit'

End

--exec UspSalaryHeader
GO
USE [master]
GO
ALTER DATABASE [SHR_SHOBIGROUP_DB] SET  READ_WRITE 
GO
