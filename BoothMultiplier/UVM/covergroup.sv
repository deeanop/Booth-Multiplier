covergroup Booth_covergroup;
  CP_BEGIN: coverpoint trans_sample.BEGIN;
  CP_END: coverpoint trans_sample.END;
  CROSS_BE: cross CP_BEGIN, CP_END;
endgroup