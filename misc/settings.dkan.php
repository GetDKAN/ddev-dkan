<?php
/**
 * @file
 * #ddev-generated: Automatically generated Drupal settings file.
 * DKAN-DDev-addon manages this file and may delete or overwrite the file unless this
 * comment is removed.  It is recommended that you leave this file alone.
 */

if ($primary_url = getenv('DDEV_PRIMARY_URL')) {
  $file_public_path = $settings['file_public_path'] ?? 'sites/default/files';
  $settings['file_public_base_url'] = $primary_url . '/' . $file_public_path;
}
