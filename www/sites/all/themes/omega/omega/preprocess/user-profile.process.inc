<?php

/**
 * Implements hook_preprocess_user_profile_category().
 */
function omega_preprocess_user_profile(&$variables) {
  $variables['attributes_array']['class'][] = 'profile';
  $variables['attributes_array']['role'] = 'article';
}
