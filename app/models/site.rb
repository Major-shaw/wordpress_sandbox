class Site < ApplicationRecord
  validates :php_version, presence: true
  validates :wp_version, presence: true

  VALID_PHP_VERSIONS = ['v1', 'v2', 'v3']
  VALID_WP_VERSIONS = ['v1', 'v2', 'v3']
  VALID_STATUSES = ['running', 'deleted']

  validates :php_version, inclusion: {in: VALID_PHP_VERSIONS}
  validates :wp_version, inclusion: {in: VALID_WP_VERSIONS}
  validates :status, inclusion: {in: VALID_STATUSES}
end
