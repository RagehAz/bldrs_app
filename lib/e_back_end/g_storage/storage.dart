import 'package:bldrs/e_back_end/g_storage/foundation/storage_byte_ops.dart';
import 'package:bldrs/e_back_end/g_storage/foundation/storage_delete_ops.dart';
import 'package:bldrs/e_back_end/g_storage/foundation/storage_file_ops.dart';
import 'package:bldrs/e_back_end/g_storage/foundation/storage_meta_ops.dart';
import 'package:bldrs/e_back_end/g_storage/foundation/storage_ref.dart';
import 'package:bldrs/e_back_end/g_storage/paths/storage_paths_generators.dart';

class Storage {
  // -----------------------------------------------------------------------------

  const Storage();
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED: WORKS PERFECT
  static const generateUserPicPath = StoragePathGenerator.generateUserPicPath;
  static const generateBzLogoPath = StoragePathGenerator.generateBzLogoPath;
  static const generateAuthorPicPath = StoragePathGenerator.generateAuthorPicPath;
  static const generateBzPostPicPath = StoragePathGenerator.generateBzPostPicPath;
  static const generateFlyerSlidePath = StoragePathGenerator.generateFlyerSlidePath;
  static const generateFlyerPosterPath = StoragePathGenerator.generateFlyerPosterPath;
  static const generateFlyerPDFPath = StoragePathGenerator.generateFlyerPDFPath;
  // -----------------------------------------------------------------------------

  /// REFERENCES

  // --------------------
  /// TESTED: WORKS PERFECT
  static const getRefByPath = StorageRef.getRefByPath;
  // --------------------
  /// TESTED: WORKS PERFECT
  static const getRefByNodes = StorageRef.getRefByNodes;
  // --------------------
  /// TESTED: WORKS PERFECT
  static const getRefByURL = StorageRef.getRefByURL;
  // --------------------
  /// TESTED: WORKS PERFECT
  static const getPathByURL = StorageRef.getPathByURL;
  // --------------------
  /// TESTED: WORKS PERFECT
  static const createURLByRef = StorageRef.createURLByRef;
  // --------------------
  /// TASK : TEST ME
  static const createURLByPath = StorageRef.createURLByPath;
  // -----------------------------------------------------------------------------

  /// CREATE DOC

  // --------------------
  /// TESTED : WORKS PERFECT
  static const uploadBytes = StorageByteOps.uploadBytes;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const uploadFileAndGetURL = StorageFileOps.uploadFileAndGetURL;
  // -----------------------------------------------------------------------------

  /// READ DOC

  // --------------------
  /// TESTED : WORKS PERFECT
  static const readBytesByPath = StorageByteOps.readBytesByPath;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const readBytesByURL = StorageByteOps.readBytesByURL;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const readFileByURL = StorageFileOps.readFileByURL;
  // --------------------
  /// TASK : TEST ME
  static const readFileByNodes = StorageFileOps.readFileByNodes;
  // -----------------------------------------------------------------------------

  /// READ META DATA

  // --------------------
  /// TESTED : WORKS PERFECT
  static const readMetaByPath = StorageMetaOps.readMetaByPath;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const readMetaByURL = StorageMetaOps.readMetaByURL;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const readMetaByNodes = StorageMetaOps.readMetaByNodes;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const readOwnersIDsByURL = StorageMetaOps.readOwnersIDsByURL;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const readOwnersIDsByNodes = StorageMetaOps.readOwnersIDsByNodes;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const readOwnersIDsByPath = StorageMetaOps.readOwnersIDsByPath;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const readDocNameByURL = StorageMetaOps.readDocNameByURL;
  // -----------------------------------------------------------------------------

  /// UPDATE META

  // --------------------
  /// TESTED : WORKS PERFECT
  static const updateMetaByURL = StorageMetaOps.updateMetaByURL;
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const deleteDoc = StorageDeletionOps.deleteDoc;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const deleteDocs = StorageDeletionOps.deleteDocs;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const deletePath = StorageDeletionOps.deletePath;
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TASK : TEST ME
  static const checkCanDeleteDocByPath = StorageMetaOps.checkCanDeleteDocByPath;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const checkCanDeleteDocByNodes = StorageMetaOps.checkCanDeleteDocByNodes;
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static const blogRef = StorageRef.blogRef;
  // -----------------------------------------------------------------------------
}
