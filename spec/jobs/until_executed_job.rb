# frozen_string_literal: true

class UntilExecutedJob
  include Sidekiq::Worker
  sidekiq_options queue: :working, retry: 1, backtrace: 10
  sidekiq_options unique: :until_executed

  sidekiq_retries_exhausted do |msg|
    logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  end

  def perform(*)
    # NO-OP
  end

  def after_unlock
    # NO OP
  end
end
